require 'tire'
class Brand < ActiveRecord::Base
  attr_accessible :desc, :englishname, :logo, :name, :status, :website
  has_many :product
  has_many :promotion
  
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esbrands'
end
