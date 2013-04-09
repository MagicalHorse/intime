require 'tire'
class Brand < ActiveRecord::Base
  attr_accessible :desc, :englishname, :logo, :name, :status, :website
  has_many :products
  has_many :promotions
  
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esbrands'
end
