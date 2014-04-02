class Ims::Store::BaseController < Ims::BaseController
  before_filter :authenticate
  layout "store"

  #检查是否是店铺导购
  def authenticate
    redirect_to ims_store_root_path if current_user.level != 3
  end
end