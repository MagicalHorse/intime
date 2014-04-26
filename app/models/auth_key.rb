# encoding: utf-8
class AuthKey < ActiveRecord::Base
  attr_accessible :desc, :private, :publickey, :status
end
