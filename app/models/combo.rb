class Combo < ActiveRecord::Base
  attr_accessible :desc, :remote_id, :combo_type, :private_to

  has_many :combo_pics
  has_many :combo_products

  def api_attrs
  	 {
  	 	:desc => desc,
  	 	:private_to => private_to,
  	 	:productids => combo_products.map(&:remote_id),
  	 	:image_ids => combo_pics.map(&:remote_id),
  	 	:product_type => combo_products.first.product_type
  	 }
  end

  def product_desc
    combo_products.sum {|x| "#{x.brand_name}#{x.category_name}"}
  end
end
