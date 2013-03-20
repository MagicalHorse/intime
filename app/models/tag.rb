class Tag < ActiveRecord::Base
  attr_accessible :desc, :name, :sortorder, :status
  has_many :product
end
