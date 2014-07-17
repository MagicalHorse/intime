# encoding: utf-8

class Ims::Store::BaseController < Ims::BaseController
  before_filter :authenticate, :fetch_template
  layout "ims/store"

  #检查是否是店铺导购
  def authenticate
    redirect_to ims_store_root_path if current_user.store_id.blank?
  end

  def fetch_template
  	store = Ims::Store.my(request)
  	@template_id = store[:data][:template_id] if store[:data].present?
  end
end
