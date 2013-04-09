require 'tire'
class Promotion < ActiveRecord::Base
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'espromotions'
  belongs_to :store
  belongs_to :tag
  has_and_belongs_to_many :products
  has_many :comments, :as=>:source
  has_many :resources, :as=>:source
  
end
