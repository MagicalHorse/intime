class Brand < ActiveRecord::Base
  attr_accessible :desc, :englishname, :logo, :name, :status, :website
  has_many :product
  has_many :promotion
end
