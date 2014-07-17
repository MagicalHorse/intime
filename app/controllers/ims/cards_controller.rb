# encoding: utf-8

class Ims::CardsController < Ims::BaseController
  before_filter :user_account_info, only: [:gift_page]
  layout "ims/user"

  # 礼品卡列表页
  def index
    @title = "礼品卡列表页"
    @can_share = true
  end

  # 给自己充值
  def recharge
    @charge_no = params[:charge_no]
    if current_user.isbindcard
      # API_NEED: 充值礼品卡接口
      @result = Ims::Giftcard.recharge(request, charge_no: @charge_no)
      if @result[:isSuccessful]
        # 置空欲充值卡号
        current_user.will_charge_no = nil
        # API_NEED: 根据礼品卡号，获取礼品卡相关信息
      else
        Rails.logger.debug(@result.to_s)
      end
      @card = Ims::Giftcard.detail(request, charge_no: @charge_no)["data"] || {}
    else
      # 如果未绑定，则跳至绑卡页面
      current_user.will_charge_no = current_user.will_charge_no || @charge_no
      current_user.charge_type = params[:charge_type]
      redirect_to new_ims_account_path
    end
  end

  # 重新赠送礼品卡页面
  def resend_gift
    flash[:page_type] = "give_show_page"
    redirect_to params[:url]
  end

  # 获赠礼品卡
  def gift_page
    @can_share = true
    @title = "获赠礼品卡"
    @charge_no = params[:charge_no].split("-").first
    @trans_id = params[:charge_no].split("-").last
    if @trans_id.to_i != 0
      @card = Ims::Giftcard.trans_detail2(request, trans_id: @trans_id)["data"] || {}
    else
      # API_NEED: 根据礼品卡号，获取礼品卡相关信息
      @card = Ims::Giftcard.transfer_detail(request, charge_no: @charge_no)["data"] || {}
    end
    @trans_id = @card[:trans_id]
    current_user.other_phone = @card[:phone]
  end

  # 接受礼品卡
  def accept
    @result = Ims::Giftcard.receive(request, charge_no: params[:charge_no], trans_id: @trans_id)
    if @result["isSuccessful"]
      redirect_to accepted_page_ims_cards_path(charge_no: params[:charge_no], trans_id: @result[:data][:trans_id])
    else
      redirect_to :back, notice: @result["message"]
    end
  end

  # 已经接受的礼品卡页面
  def accepted_page
    @charge_no = params[:charge_no]
    @trans_id = params[:trans_id]
    if @trans_id.to_i != 0
      @card = Ims::Giftcard.trans_detail2(request, trans_id: @trans_id)["data"] || {}
    else
      @card = Ims::Giftcard.transfer_detail(request, charge_no: @charge_no)["data"] || {}
    end
  end

  # 赠送页面
  def give_page
    @title = "赠送礼品卡"
    @charge_no = params[:charge_no]
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息
    if params[:trans_id].to_i != 0
      @card = Ims::Giftcard.trans_detail2(request, trans_id: params[:trans_id])["data"] || {}
    else
      @card = Ims::Giftcard.detail(request, charge_no: @charge_no)["data"]
      @card = Ims::Giftcard.transfer_detail(request, charge_no: @charge_no)["data"] if @card.blank?
      @card = {} if @card.blank?
    end
    current_user.other_phone = @card[:phone]
  end

  # 赠送给别人
  def give
    @charge_no = params[:charge_no]
    @trans_id = params[:trans_id].to_i || 0
    @notice = "请输入您的姓名" if params[:from].blank?
    if @notice
      redirect_to :back, notice: @notice
    else
      # API_NEED: 赠送礼品卡接口
      @result = Ims::Giftcard.sendex(request, charge_no: params[:charge_no], comment: (params[:comment] || "恭喜发财，大吉大利！"), phone: "", from: params[:from], trans_id: @trans_id)
      if @result["isSuccessful"]
        flash[:page_type] = "give_show_page"
        return redirect_to "/ims/cards/gift_page/#{@charge_no}-#{Time.now.to_i}-#{@result[:data][:trans_id]}"
      else
        redirect_to :back, notice: @result["message"]
      end
    end
  end

  # 不接受，归还原有用户
  def refuse
    if params[:trans_id].to_i != 0
      Ims::Giftcard.refusebytransid(request, trans_id: params[:trans_id])
    else
      # API_NEED: 拒收并退回礼品卡
      Ims::Giftcard.refuse(request, charge_no: params[:charge_no])
    end
    return redirect_to "/ims/cards/gift_page/#{params[:charge_no]}-#{Time.now.to_i}-#{params[:trans_id]}"
  end

end
