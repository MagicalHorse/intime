class ProductController < ApplicationController
  def index
    pid = params[:id]
    prod = Product.search :per_page=>1,:page=>1 do 
            query do
              match :id,pid
            end
          end
    @product = prod.results[0]
    return render :text => t(:commonerror), :status => 404 if @product.nil?
  end
  # list api always return json
  # input: 
  # => {page,pagesize,refreshts,sort,tagid,brandid,topicid,promotionid}
  # ouput:
  # => {}
  def list
    #parse input params
    pageindex = params[:page]
    pageindex ||= 1
    pagesize = params[:pagesize]
    pagesize = [(pagesize ||=40).to_i,40].min
    is_refresh = params[:type] == 'refresh'
    refreshts = params[:refreshts]
    
    # if refreshts not provide but is_refresh, return empty
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>1,
        :pagesize=>0,
        :totalcount=>0,
        :totalpaged=>0,
        :ispaged=> false
      }
     } if is_refresh == true && refreshts.nil?
     
    tagid = params[:tagid]
    brandid = params[:brandid]
    should_include_branddesc = brandid && brandid.to_i >0
    topicid = params[:topicid]
    promotionid = params[:promotionid]
    storeid = params[:storeid]
    #search the products
    prod = Product.search :per_page=>pagesize, :page=>pageindex do
          query do
            match :status,1
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
          sort {
            by :sortOrder, 'desc'
            by :createdDate, 'desc'
          }
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
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :promotionFlag =>promotion_is_expire(p)
      }
      if should_include_branddesc == true
        prod_hash[:branddesc]=p[:brand][:description]
      end
      prods_hash << prod_hash
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>pageindex,
        :pagesize=>pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/pagesize.to_f).ceil,
        :ispaged=> prod.total>pagesize,
        :products=>prods_hash
      }
     }.to_json()
    
  end
  # search api always return json
  # input :page, pagesize
  def search
    page_index_in = params[:page]
    page_size_in = params[:pagesize]
    term = params[:term]
    page_size = (page_size_in.nil?)?40:page_size_in.to_i
    page_size = 40 if page_size>40
    page_index = (page_index_in.nil?)?1:page_index_in.to_i
    term = '' if term.nil?
    products =  Product.search :per_page=>page_size,:page=>page_index do    
         query do
              match ['*.name','*.description','*.engname','*.recommendreason'], term
              match :status,1
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
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :promotionFlag =>promotion_is_expire(p)
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>page_index,
        :pagesize=>page_size,
        :totalcount=>products.total,
        :totalpaged=>(products.total/page_size.to_f).ceil,
        :ispaged=> products.total>page_size,
        :products=>prods_hash
      }
     }.to_json()
  end
 
private 
  def promotion_is_expire(p)
    (p[:promotion].nil?)||p[:promotion].length<1||(p[:promotion].sort{|x,y| y[:endDate].to_time<=>x[:endDate].to_time}[0][:endDate].to_time<Time.now)?false:true
  end
    
end
