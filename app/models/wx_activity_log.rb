# encoding: utf-8
class WxActivityLog < ActiveRecord::Base
  attr_accessible :activity_id, :uid, :vip_card
end
