# encoding: utf-8
require 'cgi'
class StoreCouponController < ApiBaseController
  before_filter :auth_api2,:only=>[:consume]
  def consume
    check_message = []
  
    if params[:data].nil?
      outmsg<<'input request not contain data node!'
      return render :json=> error_500_msg(check_message.join)
    end 
    sale_type = params[:data][:saletype]
    sale_type ||= '1'
    return consume_internal if sale_type == '1'
    return rebate_internal if sale_type == '2'
    return render :json=>{:isSuccessful=>false,
      :message =>'unrecognized sale type!',
      :statusCode =>'500'
    }
  end
 
  
  def logs

    return render :json=> error_500_msg('params data not set!') if params[:data].nil?
    bendate = params[:data][:benchdate]
    used_coupons = StoreCouponLog.where('created_at>=?',bendate)
    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>used_coupons
     }
  end
  
  def void
    return render :json=> error_500_msg('params data not set!') if params[:data].nil?
    coupon_code = params[:data][:code].to_s
    # coupon used or not
    #return render :json=> error_used_msg unless StoreCouponLog.find_by_code(coupon_code).nil?
    exist_coupon = StoreCoupon.find_by_code_and_coupontype(coupon_code,1)
    return render :json=> error_used_msg if (exist_coupon && [10,-1].include?(exist_coupon.status.to_i))
    
    # void coupon
    if exist_coupon
     exist_coupon.status = -1
     exist_coupon.save
    end

    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{}
     }
  end
  
  private 
   def consume_internal  
     check_message = [] 
    @coupon_flag = params[:data][:flag]
    @coupon_flag ||='1'
    @coupon_type = params[:data][:giftno].to_s.start_with?('9')?1:2
    exist_coupon = StoreCoupon.find_by_code_and_coupontype(params[:data][:giftno],@coupon_type)
   
    if @coupon_type == 1 && @coupon_flag== '1'
      # check vipcard too
      return render :json=>error_500_msg(check_message.join) if check_consume_params(exist_coupon,check_message)==false
      return render :json=>error_card_notmatch unless exist_coupon.vipcard.to_s.chomp==params[:data][:vipno].to_s.chomp
      return render :json=>error_500 {t(:scc_amount_notmatch)} unless exist_coupon.amount==params[:data][:amount].to_f
    elsif @coupon_type ==2 && @coupon_flag == '2'
      return render :json=>error_500_msg(check_message.join) if check_proconsume_params(exist_coupon,check_message)==false
    else
      return render :json=>error_500 {t(:scc_codenotexist)}
    end
    exist_coupon.status=10
    StoreCoupon.transaction do 
      exist_coupon.save
      StoreCouponLog.create(:coupontype=>@coupon_type,
      :code=>exist_coupon.code,
      :storeno=>params[:data][:storeno],
      :receiptno=>params[:data][:receiptno],
      :status=>1)
    end
    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{ 
        :amount=>exist_coupon.amount     
      }
     }
  end
  
  def rebate_internal
    check_message = []
    @coupon_flag = params[:data][:flag]
    @coupon_flag ||='1'
    @coupon_type = params[:data][:giftno].to_s.start_with?('9')?1:2
    exist_coupon = StoreCoupon.find_by_code_and_coupontype(params[:data][:giftno],@coupon_type)
   return render :json=>error_500_msg(check_message.join) if check_rebate_params(exist_coupon,check_message)==false
    if @coupon_type == 1 && @coupon_flag == '1'
      # check vipcard too
      return render :json=>error_card_notmatch unless exist_coupon.vipcard.to_s.chomp==params[:data][:vipno].to_s.chomp
    else
      error_msg = t(:scc_codenotexist)
      error_msg = t(:scc_p_codenotexist) if @coupon_flag=='2'
      return render :json=>error_500 {error_msg}
    end
    exist_coupon.status=1
    StoreCoupon.transaction do 
      exist_coupon.save
      StoreCouponLog.create(:coupontype=>@coupon_type,
      :code=>exist_coupon.code,
      :storeno=>params[:data][:storeno],
      :receiptno=>params[:data][:receiptno],
       :status=>-1)
    end
    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      
     }
  end
  def error_used_msg
    {:isSuccessful=>false,:message=>'coupon used!',:statusCode=>'500'}
  end
  def check_consume_params(exist_coupon,outmsg)
    if exist_coupon.nil?
      outmsg<<t(:scc_codenotexist)
      return false
    end
    if exist_coupon.status!=1
      outmsg<<t(:scc_codehasused)
      return false
    end
    if exist_coupon.validstartdate>Time.now || exist_coupon.validenddate<Time.now
      outmsg<<t(:scc_codeexpiredornotstart)
      return false
    end

  end
  
  def check_proconsume_params(exist_coupon,outmsg)
    if exist_coupon.nil?
      outmsg<<t(:scc_p_codenotexist)
      return false
    end
    if exist_coupon.islimitonce==true && exist_coupon.status!=1
      outmsg<<t(:scc_p_codehasused)
      return false
    end
    if exist_coupon.validstartdate>Time.now || exist_coupon.validenddate<Time.now
      outmsg<<t(:scc_p_codeexpiredornotstart)
      return false
    end
  end
  def error_card_notmatch
    {:isSuccessful=>false,:message=>t(:scc_cardnotmatch),:statusCode=>'500'}
  end
  def check_rebate_params(exist_coupon,outmsg)
    if exist_coupon.nil?
      outmsg<<t(:scc_codenotexist)
      return false
    end
    if exist_coupon.status!=10
      outmsg<<t(:scc_codenotused)
      return false
    end

  end
end
