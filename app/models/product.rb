require 'tire'
class Product < ActiveRecord::Base
  belongs_to :store
  belongs_to :tag
  belongs_to :user
  belongs_to :updateduser,:class_name=>'User'
  has_and_belongs_to_many :promotions
  has_many :comments, :as=>:source
  has_many :resources, :as=>:source

  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esproducts'
end
