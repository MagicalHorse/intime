class User < ActiveRecord::Base
  attr_accessible :email, :level, :logo, :mobile, :name, :nickie, :pwd, :status
end
