# encoding: utf-8
class CardController < ApiBaseController
  def find
    uid = params[:data][:uid]
    return render :json=> error_500_msg('no params!') if uid.nil?
    card_info = Card.where(:utoken=>uid,:isbinded=>true).order('updated_at desc').first
    return render :json=> error_500_msg('no card') if card_info.nil?
    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>card_info.decryp_card_no
     }
  end
end
