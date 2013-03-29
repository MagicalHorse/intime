require 'tire'
class Tag < ActiveRecord::Base
  attr_accessible :desc, :name, :sortorder, :status
  has_many :product
  
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'estags'
end
