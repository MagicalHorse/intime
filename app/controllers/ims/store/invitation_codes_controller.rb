# encoding: utf-8

class Ims::Store::InvitationCodesController < Ims::Store::BaseController
  skip_before_filter :authenticate, only: [:new, :create]
  before_filter :stores
  before_filter :verify_can_apply_invitation_code, only: [:new, :create]

  def new
    @title = "开店申请"
  end

  def create
    if current_user.sms_code == params[:sms_code]
      @store = Ims::Store.requestcode_dg(request, params[:invitation_code])
      render json: {status: @store[:isSuccessful], message: @store[:message]}
    else
      render json: {status: false, message: "手机验证码输入错误"}
    end
  end

  def update
    if current_user.sms_code == params[:sms_code]
      @store = Ims::Store.requestcode_upgrade(request, params[:invitation_code])
      render json: {status: @store[:isSuccessful], message: @store[:message]}
    else
      render json: {status: false, message: "手机验证码输入错误"}
    end
  end

  def upgrade
    @title = "店铺升级申请"
  end


  protected

  def stores
    @stores = ::Store.es_search(group_id: session[:group_id])
    @departments = {}
    @stores.each{|store| @departments[store["id"]] = store["departments"].collect{|department| {'id' => department[:id], 'name' => department[:name]}}}
    @departments = @departments.to_json
  end

  def verify_can_apply_invitation_code
    redirect_to ims_store_root_path if current_user.associate_id.present?
  end

end
