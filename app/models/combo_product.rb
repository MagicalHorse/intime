class ComboProduct < ActiveRecord::Base
  attr_accessible :remote_id, :combo_id, :img_url, :product_type

  belongs_to :combo
end
