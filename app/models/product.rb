require 'tire'
class Product < ActiveRecord::Base
  belongs_to :store
  belongs_to :tag
  belongs_to :user
  #has_and_belongs_to :promotion
  attr_accessible :desc, :name, :price, :recommendreason, :sortorder, :status
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esproducts'
end
