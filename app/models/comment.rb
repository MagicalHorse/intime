# encoding: utf-8
class Comment < ActiveRecord::Base
  attr_accessible :status, :textmsg,:source_id,:source_type,:reply_id,:user_id
  belongs_to :user
  belongs_to :source, :polymorphic=>true
  has_many :replies, :class_name=>'Comment',:foreign_key=>'reply_id'
  has_many :resource, :as=>:source
  belongs_to :parent, :class_name=>'Comment'
end

