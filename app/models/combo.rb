class Combo < ActiveRecord::Base
  attr_accessible :desc, :remote_id, :combo_type, :private_to

  has_many :combo_pics
  has_many :combo_products

  def api_attrs
  	 # {
  	 # 	:desc => desc,
  	 # 	:private_to => private_to,
  	 # 	:productids => combo_products.map(&:remote_id),
  	 # 	:image_ids => combo_pics.map(&:remote_id),
  	 # 	:combo_type => combo_products.first.combo_type
  	 # }

  	 {
  	 	:desc => "testtesttesttesttesttest",
  	 	:private_to => "张先生",
  	 	:productids => [1,2,3],
  	 	:image_ids => [1,2,3],
  	 	:combo_type => "1"
  	 }
  end
end
