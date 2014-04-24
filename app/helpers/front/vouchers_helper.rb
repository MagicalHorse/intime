# encoding: utf-8
module Front::VouchersHelper
  def fetch_user_card_info
    return nil unless current_user.isbindcard

    card_info = API::Card.detail(request, cardno: current_user.cardno)['data']
  end
end
