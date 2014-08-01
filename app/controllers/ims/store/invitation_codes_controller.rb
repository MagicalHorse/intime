# encoding: utf-8

class Ims::Store::InvitationCodesController < Ims::Store::BaseController
  skip_before_filter :authenticate, only: [:new, :create]
  before_filter :stores
  before_filter :verify_can_apply_invitation_code, only: [:new, :create]

  def new
    @title = "申请邀请码"
  end

  def create
    if current_user.sms_code == params[:sms_code]
      @store = Ims::Store.requestcode_dg(request, params[:invitation_code])
      render json: {status: @store[:isSuccessful], message: @store[:message]}
    else
      render json: {status: false, message: "手机验证码输入错误"}
    end
  end

  def upgrade
    @title = "升级店铺"
  end

  protected

  def stores
    @stores = ::Store.es_search
  end

  def verify_can_apply_invitation_code
    redirect_to ims_store_root_path if current_user.store_id.present?
  end

end
