# encoding: utf-8
class Combo < ActiveRecord::Base
  DOCUMENT_TYPE = "escombos"

  attr_accessible :desc, :remote_id, :combo_type, :private_to, :has_discount, :discount, :is_public

  has_many :combo_pics
  has_many :combo_products

  default_value_for :is_public, false

  def api_attrs
  	{
  	 	:desc => desc,
  	 	:private_to => private_to,
  	 	:productids => combo_products.map(&:remote_id).uniq.compact,
  	 	:image_ids => combo_pics.map(&:remote_id).uniq.compact,
  	 	:product_type => combo_products.first.product_type,
      :has_discount => has_discount,
      :discount => discount,
      :is_public => is_public
  	}
  end

  def product_desc
    combo_products.map {|x| "#{x.brand_name}#{x.category_name}"}.uniq.compact.join(",")
  end

  def self.img_url(combo)
    resource = combo['resources'].find do |resource|
      resource.try(:[], :name).present?
    end
    if resource.present?
      img_url = [PIC_DOMAIN, resource['name'], "_320x0.jpg"].join('')
    else
      Settings.default_image_url.product.middle
    end
  end

  def can_edit_pro?
    combo_products.all?{|product| product.product_type == "2"}
  end

  include Tire::Model::Search
  extend Searchable
  index_name ES_DEFAULT_INDEX
  document_type DOCUMENT_TYPE

  def self.es_search(options={})
    keywords = options[:keywords]
    store_id = options[:store_id]
    group_id = options[:group_id]
    per_page = options[:per_page].present? ? options[:per_page].to_i : 10
    page = options[:page].present? ? options[:page].to_i : 1
    query = Jbuilder.encode do |json|

      if keywords.present?
        json.query do
          json.query_string do
            json.fields ['brands.name^2','associateName']
            json.query keywords
            json.use_dis_max true
            json.minimum_should_match '75%'
          end
        end
      end

      json.filter do
        json.and do
          json.child! do
            json.range do
              json.expireDate do
                json.gt Time.now
              end
            end
          end

          json.child! do
            json.term do
              json.status 1
            end
          end


          if store_id.present?
            json.child! do
              json.term do
                json.storeId store_id
              end
            end
          end

          if group_id.present?
            json.child! do
              json.term do
                json.set! 'group.id', group_id
              end
            end
          end

        end
      end
      if !keywords.present?
        json.sort do
          json.createDate "desc"
        end
      end

    end
    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: per_page, from: (page-1) * per_page, body: query
    mash = Hashie::Mash.new result
    {count: mash.hits.total, page: page, per_page: per_page, group_id: group_id, data: mash.hits.hits.collect(&:_source)}
  end
end
