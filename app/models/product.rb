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

  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type DOCUMENT_TYPE

  def self.es_search(options={})
    from_discount = options[:from_discount]
    to_discount = options[:to_discount]
    from_price = options[:from_price]
    to_price = options[:to_price]
    brand_id = options[:brand_id]
    keywords = options[:keywords].try(:downcase)
    per_page = options[:per_page] || 20
    page = options[:page] || 1



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

          if brand_id.present?
            json.child! do
              json.term do
                json.set! "brand.id", brand_id
              end
            end
          end

          json.child! do
            json.term do
              json.status 1
              # json.status 0
            end
          end



        end

      end


      if keywords.present?
        json.query do
          json.bool do
            json.should do

              json.wildcard do
                json.name "*#{keywords}*"
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

    result = $client.search index: "intimep", type: DOCUMENT_TYPE, size: per_page, from: (page-1)*per_page, body: query
    mash = Hashie::Mash.new result
    mash.hits.hits.collect(&:_source)
  end
end
