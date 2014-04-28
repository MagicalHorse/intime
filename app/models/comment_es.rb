# encoding: utf-8
require 'tire'
class CommentES
  include Tire::Model::Persistence
  index_name ES_DEFAULT_INDEX
  document_type 'escomments'
  
  property :status
  property :textmsg
  property :sourceid
  property :sourcetype
  property :reply_id
  property :user

  def self.subscribe(msg)
    return if msg.nil?
    user = {:id=>msg[:user][:id],:logo=>msg[:user][:logo],:nickie=>msg[:user][:nickie],:level=>msg[:user][:level]}
    self.create :status => msg[:status],
              :id => msg[:id],
              :textmsg => msg[:textmsg],
              :sourceid => msg[:sourceid],
              :sourcetype => msg[:sourcetype],
              :reply_id => msg[:reply_id],
              :user =>  user
    Rails.logger.info "end process comment:#{msg[:id]}"
  end
end
