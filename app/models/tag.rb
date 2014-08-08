# encoding: utf-8
require 'tire'
class Tag < ActiveRecord::Base
  DOCUMENT_TYPE = "estags"
  attr_accessible :desc, :name, :sortorder, :status
  has_many :products

  extend Searchable
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type DOCUMENT_TYPE


  def self.es_search(options={})

    per_page = [options[:per_page], 10000].find{|obj| obj.present?}.to_i
    page = [options[:page], 1].find{|obj| obj.present?}.to_i
    category_id = options[:category_id]

    query = Jbuilder.encode do |json|

      json.filter do

        json.and do

          if category_id.present?
            json.child! do
              json.term do
                json.id category_id
              end
            end
          end

          json.child! do
            json.term do
              json.status 1
            end
          end

        end

      end


      # json.sort do
      #   json.sortOrder "asc"
      # end
    end

    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: per_page, from: (page-1)*per_page, body: query
    mash = Hashie::Mash.new result
    count = mash["hits"]["total"]
    {count: count, page: page, per_page: per_page, data: mash.hits.hits.collect(&:_source)}
  end


  def self.es_imstags_search(options={})

    per_page = [options[:per_page], 10000].find{|obj| obj.present?}.to_i
    page = [options[:page], 1].find{|obj| obj.present?}.to_i

    query = Jbuilder.encode do |json|

      json.filter do

        json.and do

          json.child! do
            json.term do
              json.status 1
            end
          end

        end

      end

      # json.sort do
      #   json.sortOrder "asc"
      # end
    end

    result = $client.search index: ES_DEFAULT_INDEX, type: "esimstags", size: per_page, from: (page-1)*per_page, body: query
    mash = Hashie::Mash.new result
    count = mash["hits"]["total"]
    {count: count, page: page, per_page: per_page, data: mash.hits.hits.collect(&:_source)}
  end

  def self.list_all()
    prod = Tag.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
          sort {
            by :sortOrder,'desc'
          }
    end
    # render request
    prods_hash = []
    prod.results.each {|p|
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :description=>p[:description],
        :sortorder=>p[:sortOrder]
      }
    }
    success do
      prods_hash
    end

  end
end
