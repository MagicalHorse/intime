# encoding: utf-8
require 'tire'
class Product < ActiveRecord::Base
  DOCUMENT_TYPE = "esproducts"
  belongs_to :store
  belongs_to :tag
  belongs_to :user
  belongs_to :updateduser,:class_name=>'User'
  has_and_belongs_to_many :promotions
  has_many :comments, :as=>:source
  has_many :resources, :as=>:source

  extend Searchable
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX

  document_type DOCUMENT_TYPE

  def self.es_search(options={})
    id = options[:id]
    from_discount = options[:from_discount]
    to_discount = options[:to_discount]
    from_price = options[:from_price]
    to_price = options[:to_price]
    brand_id = options[:brand_id]
    store_id = options[:store_id]
    gte = options[:gte]
    keywords = options[:keywords].try(:downcase)
    is_system = options[:is_system]
    per_page = [options[:per_page], 10].find{|obj| obj.present?}.to_i
    page = [options[:page], 1].find{|obj| obj.present?}.to_i


    query = Jbuilder.encode do |json|

      json.filter do

        json.and do

          if from_price.present?

            json.child! do
              json.range do
                json.price do
                  json.gte from_price
                end
              end
            end

          end

          if to_price.present?

            json.child! do
              json.range do
                json.price do
                  json.lte to_price
                end
              end
            end

          end

          if from_discount.present?

            json.child! do
              json.range do
                json.discountRate do
                  json.gte from_discount
                end
              end
            end

            json.child! do
              json.range do
                json.discountRate do
                  json.lte 100
                end
              end
            end

          end

          if to_discount.present?

            json.child! do
              json.range do
                json.discountRate do
                  json.lte to_discount
                end
              end
            end

          end

          if gte.present?  #其他专柜商品搜索过滤7天

            json.child! do
              json.range do
                json.createdDate do
                  json.gte Time.now - gte.to_i.days
                end
              end
            end

          end

          if brand_id.present?
            json.child! do
              json.term do
                json.set! "brand.id", brand_id
              end
            end
          end

          if store_id.present?
            json.child! do
              json.term do
                json.set! "store.id", store_id
              end
            end
          end

          if id.present?
            json.child! do
              json.term do
                json.id id
              end
            end
          end

          json.child! do
            json.term do
              json.status 1
            end
          end

          if is_system.present?
            json.child! do
              json.term do
                json.isSystem is_system == "1"
              end
            end
          end

          json.child! do
            json.term do
              json.is4Sale true
            end
          end



        end

      end

      if keywords.present?
        json.query do
          json.bool do

            json.should do
              json.child! do
                json.wildcard do
                  json.name "*"+keywords+"*"
                end
              end

              json.child! do
                json.wildcard do
                  json.set! "brand.name", "*"+keywords+"*"
                end
              end

              json.child! do
                json.wildcard do
                  json.upcCode "*"+keywords+"*"
                end
              end

              json.child! do
                json.match do
                  json.name keywords
                end
              end

              json.child! do
                json.match do
                  json.upcCode keywords
                end
              end

              json.child! do
                json.match do
                  json.set! "brand.name", keywords
                end
              end

            end


            json.minimum_number_should_match 1
            json.boost 1.0
          end
        end
      end


      json.sort do
        json.createdDate "desc"
      end
    end
    # result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: 10000000, body: query
    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: per_page, from: (page-1)*per_page, body: query
    mash = Hashie::Mash.new result
    count = mash["hits"]["total"]
    {count: count, page: page, per_page: per_page, from_discount: from_discount, to_discount: to_discount, from_price: from_price, to_price: to_price, brand_id: brand_id, is_system: is_system, keywords: keywords, data: mash.hits.hits.collect(&:_source)}
  end


  def self.fetch_product(id)
    data = self.es_search(id: id)[:data].first || {}
    if data.present?
      r = data[:resource].first if data[:resource].present?
      image = self.img_url(r) if r.present?

      return {:data => {:id => data[:id], :price => data[:price], :image => image, :brand_name => data[:brand][:name], :category_name => data[:tag][:name]}}
    else
      return nil
    end
  end

  def self.img_url(r)
    if r.is_a?(::Hash) && (name = r[:name] || r['name']).present?
      PIC_DOMAIN + name.to_s + '_320x0.jpg'
    else
      Settings.default_image_url.product.middle
    end
  end


  def self.list_by_page(options={})
    #parse input params
    pageindex = options[:page]
    pageindex ||= 1
    pagesize = options[:pagesize]
    pagesize = [(pagesize ||=40).to_i,40].min
    is_refresh = options[:type] == 'refresh'
    refreshts = options[:refreshts]

    # if refreshts not provide but is_refresh, return empty
    return success do {
        :pageindex=>1,
        :pagesize=>0,
        :totalcount=>0,
        :totalpaged=>0,
        :ispaged=> false
        }
      end if is_refresh == true && refreshts.nil?

    tagid = options[:tagid]
    brandid = options[:brandid]
    should_include_branddesc = brandid && brandid.to_i >0
    topicid = options[:topicid]
    promotionid = options[:promotionid]
    storeid = options[:storeid]
    sort_by = options[:sortby]
    sort_by ||= 4
    #search the products
    prod = Product.search :per_page=>pagesize, :page=>pageindex do
          query do
            match :status,1
            match :isSystem,true
            if !(tagid.nil?) && tagid.to_i>0
              #find by tag
              match 'tag.id',tagid
            elsif !(brandid.nil?) && brandid.to_i >0
              #find by brand
              match 'brand.id',brandid
            elsif !(topicid.nil?) && topicid.to_i >0
              #find by special topic
              match 'specialTopic.id',topicid
            elsif !(promotionid.nil?) && promotionid.to_i >0
              #find by promotion id
              match 'promotion.id',promotionid
              match 'promotion.status',1
             elsif storeid && storeid.to_i >0
               # find by store id
               match 'store.id',storeid
            end
          end
          if is_refresh
            filter :range,{
              'createdDate' =>{
                'gte'=>refreshts.to_datetime
              }
            }
          end
          case sort_by.to_i
          when 2 then sort {by :price,'desc'}
          when 3 then sort {by :price}
          when 4 then sort {by :sortOrder,'desc'}
          else sort {by :createdDate,'desc'}
          end

    end
    # render request
    prods_hash = []
    prod.results.each {|p|
      default_resource = select_defaultresource p[:resource]
      next if default_resource.nil?
      prod_hash = {
        :id=>p[:id],
        :name=>p[:name],
        :price=>p[:price],
        :unitprice=>p[:unitPrice],
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :promotionFlag =>promotion_is_expire(p),
        :likecount=>p[:favoriteCount],
        :is4sale=>p[:is4Sale]
      }
      if should_include_branddesc == true
        prod_hash[:branddesc]=p[:brand][:description]
      end
      prods_hash << prod_hash
    }
    success do
      {
        :pageindex=>pageindex,
        :pagesize=>pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/pagesize.to_f).ceil,
        :ispaged=> prod.total>pagesize,
        :products=>prods_hash
      }
    end

  end
  def self.search_by_key(options={})
    page_index_in = options[:page]
    page_size_in = options[:pagesize]
    term = options[:term]
    page_size = (page_size_in.nil?)?40:page_size_in.to_i
    page_size = 40 if page_size>40
    page_index = (page_index_in.nil?)?1:page_index_in.to_i
    term = '' if term.nil?
    products =  Product.search :per_page=>page_size,:page=>page_index do
          min_score 1
         query do
              string term, {:fields=>['upcCode','name','description','brand.name','brand.engname','recommendreason'],:minimum_should_match=>'75%'}
              match :status,1
              match :isSystem,true
            end
          end
    prods_hash = []
    products.results.each {|p|
      default_resource = select_defaultresource p[:resource]
      next if default_resource.nil?
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :price=>p[:price],
        :unitprice=>p[:unitPrice],
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :promotionFlag =>promotion_is_expire(p),
        :likecount=>p[:favoriteCount],
        :is4sale=>p[:is4Sale]
      }
    }
    success do
      {
      :pageindex=>page_index,
      :pagesize=>page_size,
      :totalcount=>products.total,
      :totalpaged=>(products.total/page_size.to_f).ceil,
      :ispaged=> products.total>page_size,
      :products=>prods_hash
      }
    end

  end
  def self.get_by_id(options={})
    pid = options[:id]
    prod = Product.search :per_page=>1,:page=>1 do
            query do
              match :id,pid
            end
          end
    return error_500 if prod.total<=0
    next_gt_pid = nil
    next_lt_pid = nil
    next_gt_prod = Product.search :per_page=>1,:page=>1 do
            query do
              match :status,1
              match :isSystem,true
            end
            filter :range,{
                  'id' =>{
                    'gt'=>pid
                  }
                }
          end
    next_gt_pid = next_gt_prod.results[0][:id] if next_gt_prod.total>0
    next_lt_prod = Product.search :per_page=>1,:page=>1 do
            query do
              match :status,1
              match :isSystem,true
            end
            filter :range,{
                  'id' =>{
                    'lt'=>pid
                  }
                }
          end
    next_lt_pid = next_lt_prod.results[0][:id] if next_lt_prod.total>0
    prod_model = prod.results[0]
    recommend_user = User.esfind_by_id prod_model[:createUserId]
    recommend_user||={:id=>0,:nickname=>nil,:level=>nil,:logon=>nil}
    valid_promotions = find_valid_promotions(prod_model[:promotion])
    section_phone = prod_model[:section][:contactPhone] unless prod_model[:section].nil?
    success do
      {
        :id=>prod_model[:id],
        :name=>prod_model[:name],
        :brand=>prod_model[:brand],
        :description=>prod_model[:description],
        :price=>prod_model[:price],
        :unitprice=>prod_model[:unitPrice],
        :recommendedreason=>prod_model[:recommendedReason],
        :recommenduser_id=>prod_model[:recommendUserId],
        :recommenduser=>{
          :id=>recommend_user[:id],
          :nickname=>recommend_user[:nickie],
          :level=>recommend_user[:level],
          :logo=>Resource.absolute_url(recommend_user[:thumnail])
          },
        :favoritecount=>prod_model[:favoriteCount],
        :likecount=>prod_model[:favoriteCount],
        :sharecount=>prod_model[:shareCount],
        :couponcount=>prod_model[:involvedCount],
        :resources=>sort_resource(prod_model[:resource]),
        :tag=>prod_model[:tag],
        :store=>Store.to_store_with_distace(prod_model[:store],[options[:lat]||=0,options[:lng]||=0]),
        :promotions=>valid_promotions,
        :is4sale=>prod_model[:is4Sale],
        :contactphone=>section_phone,
        :skucode=>prod_model[:upcCode],
        :nextgtpid=>next_gt_pid,
        :nextltpid=>next_lt_pid,
        :isSystem=>prod_model[:isSystem]
       }
    end


  end
end
