# encoding: utf-8
class Combo < ActiveRecord::Base
  DOCUMENT_TYPE = "escombos"

  attr_accessible :desc, :remote_id, :combo_type, :private_to, :has_discount, :discount, :is_public

  has_many :combo_pics
  has_many :combo_products

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
      img_url = [PIC_DOMAIN, resource['name'], "_640X0.jpg"].join('')
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
    size = options[:size] || 10000000
    keywords = options[:keywords] || "JAGGY"
    store_id = options[:store_id]
    query = Jbuilder.encode do |json|

      if keywords.present?
        json.query do
          json.bool do
            json.should do

              json.child! do
                json.wildcard do
                  json.associateName "*"+keywords+"*"
                end
              end

              json.child! do
                json.match do
                  json.associateName keywords
                end
              end

              json.child! do
                json.wildcard do
                  json.set! "brands.name", "*"+keywords+"*"
                end
              end

              json.child! do
                json.match do
                  json.set! "brands.name", keywords
                end
              end

            end


            json.minimum_number_should_match 1
            json.boost 1.0
          end
        end
      end

      json.filter do
        json.and do
          json.child! do
            json.range do
              json.expireDate do
                json.gt Time.now.strftime('%Y-%m-%d')
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
        end
      end

      json.sort do
        json.createDate "desc"
      end

    end
    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: size, body: query
    mash = Hashie::Mash.new result
    mash.hits.hits.collect(&:_source)
  end
end
