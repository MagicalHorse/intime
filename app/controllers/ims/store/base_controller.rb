class Ims::Store::BaseController < Ims::BaseController
  before_filter :authenticate
  layout "store"

  #检查是否是店铺主人
  def authenticate

  end
end