require 'tire'
class Brand < ActiveRecord::Base
  DOCUMENT_TYPE = "esbrands"
  attr_accessible :desc, :englishname, :logo, :name, :status, :website
  has_many :products
  has_many :promotions

  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type DOCUMENT_TYPE


  def self.es_search(options={})
    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: 10000000
    mash = Hashie::Mash.new result
    mash.hits.hits.collect(&:_source)
  end

end
