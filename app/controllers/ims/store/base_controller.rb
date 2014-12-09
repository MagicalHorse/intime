# encoding: utf-8

class Ims::Store::BaseController < Ims::BaseController
  before_filter :authenticate, :fetch_template
  layout "ims/store"

  #检查是否是店铺导购
  def authenticate
    if current_user.associate_id.blank?
      if is_mobile
        redirect_to ims_store_root_path
      else
        redirect_to login_ims_weixins_path
      end
    end
  end

  def fetch_template
    @store = Ims::Store.my(request)
    @template_id = @store[:data][:template_id] if @store[:data].present?
  end
end
