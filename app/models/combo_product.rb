# -*- encoding : utf-8 -*-
class ComboProduct < ActiveRecord::Base
  attr_accessible :remote_id, :combo_id, :img_url, :product_type, :price, :brand_name, :category_name

  belongs_to :combo

  after_create :recount_combo_price
  before_destroy :recount_combo_price

  def recount_combo_price
  	 combo.update_attribute(:price, combo.combo_products.sum(&:price))
  end
end
