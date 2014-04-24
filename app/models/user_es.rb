# encoding: utf-8
require 'tire'
class UserES
  include Tire::Model::Persistence
  index_name ES_DEFAULT_INDEX
  document_type 'esusers'
  
  property :status
  property :email
  property :level
  property :logo
  property :mobile
  property :name
  property :nickie
  property :pwd

end
