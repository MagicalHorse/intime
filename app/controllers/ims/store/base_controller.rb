class Ims::Store::BaseController < Ims::BaseController
  before_filter :authenticate

  #检查是否是店铺主人
  def authenticate
  	 
  end
end