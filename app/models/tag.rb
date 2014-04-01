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

    query = nil
    per_page = options[:per_page] || 20
    page = options[:page] || 1

    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: per_page, from: (page-1)*per_page, body: query
    mash = Hashie::Mash.new result
    mash.hits.hits.collect(&:_source)
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
