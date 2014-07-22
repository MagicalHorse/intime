# encoding: utf-8

class Ims::Store::InvitationCodesController < Ims::Store::BaseController

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

end
