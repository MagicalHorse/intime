# encoding: utf-8

class Ims::SmsCodesController < Ims::BaseController

  def create
    @title = "验证码"
    @phone = params[:phone].try(:strip)
    generate_sms @phone
    render json: {status: true}
  end

end