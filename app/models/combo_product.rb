# encoding: utf-8
class ComboProduct < ActiveRecord::Base
  attr_accessible :remote_id, :combo_id, :img_url, :product_type, :price, :brand_name, :category_name, :unitprice

  belongs_to :combo

  after_create :recount_combo_price
  before_destroy :recount_combo_price
  validate :verify_product_count, on: :create
  validates :remote_id, uniqueness: {scope: :combo_id, message: "该商品已经添加"}

  def recount_combo_price
  	combo.update_attribute(:price, combo.combo_products.sum(&:price))
  end

  def verify_product_count
    errors.add(:base, "一个组合最多添加6个商品") if ComboProduct.where(combo_id: combo_id).count >= 6
  end

  def img_url
    img_url = read_attribute(:img_url)
    img_url.present? ? img_url : @img_url || Settings.default_image_url.product.middle
  end

end
