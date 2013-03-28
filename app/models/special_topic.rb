require 'tire'

class SpecialTopic < ActiveRecord::Base
  attr_accessible :desc, :name, :status
   include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esspecialtopics'
end
