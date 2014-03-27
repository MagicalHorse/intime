class Combo < ActiveRecord::Base
  attr_accessible :desc, :remote_id, :combo_type, :private_to

  has_many :combo_pics
  has_many :combo_products

end
