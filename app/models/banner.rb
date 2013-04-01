require 'tire'
class Banner < ActiveRecord::Base
  attr_accessible :sortorder, :status
  
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esbanners'
end
