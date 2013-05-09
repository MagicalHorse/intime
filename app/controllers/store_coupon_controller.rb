require 'cgi'
class StoreCouponController < ApiBaseController
  def consume
    check_message = []
  
    if params[:data].nil?
      outmsg<<'input request not contain data node!'
      return render :json=> error_500_msg(check_message.join)
    end 
    @coupon_type = params[:data][:code].to_s.start_with?('9')?1:2
    exist_coupon = StoreCoupon.find_by_code_and_coupontype(params[:data][:code],@coupon_type)
    return render :json=>error_500_msg(check_message.join) if check_consume_params(exist_coupon,check_message)==false
    exist_coupon.status=10
    StoreCoupon.transaction do 
      exist_coupon.save
      StoreCouponLog.create(:coupontype=>@coupon_type,:code=>exist_coupon.code)
    end
    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{ 
        :amount=>exist_coupon.amount     
      }
     }
  end
  
  def logs

    return render :json=> error_500_msg('params data not set!') if params[:data].nil?
    bendate = params[:data][:benchdate].to_time
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
    return render :json=> error_used_msg unless StoreCouponLog.find_by_code(coupon_code).nil?
    exist_coupon = StoreCoupon.find_by_code_and_coupontype(coupon_code,1)
    return render :json=> error_used_msg if (exist_coupon && [10,-1].include?(exist_coupon.status.to_i))
    
    # void coupon
     exist_coupon.status = -1
     exist_coupon.save

    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{}
     }
  end
  private 
  def error_used_msg
    {:isSuccessful=>false,:message=>'coupon used!',:statusCode=>'500'}
  end
  def check_consume_params(exist_coupon,outmsg)
    if exist_coupon.nil?
      outmsg<<'code not exist!'
      return false
    end
    if exist_coupon.status!=1
      outmsg<<'coupon has been used!'
      return false
    end
    if exist_coupon.validstartdate>Time.now || exist_coupon.validenddate<Time.now
      outmsg<<'coupon expired or not started!'
      return false
    end
    if StoreCouponLog.find_by_code_and_coupontype(exist_coupon.code,@coupon_type)
      outmsg<<'coupon has been used!'
      return false
    end
  end
end
