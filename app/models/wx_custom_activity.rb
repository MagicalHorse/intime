# encoding: utf-8
class WxCustomActivity < ActiveRecord::Base
  attr_accessible :key, :status, :succsss_msg, :valid_end, :valid_from,:join_msg,:how_msg
end
