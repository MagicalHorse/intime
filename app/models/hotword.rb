require 'tire'
class Hotword < ActiveRecord::Base
  attr_accessible :brandid, :sortorder, :status, :type, :word
  
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'eshotwords'
end
