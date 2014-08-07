# encoding: utf-8

class Ims::Store::SellsController < Ims::Store::BaseController


  def index
    @search_gift_card = Ims::Giftcard.all(request, page: params[:gift_card_page], pagesize: params[:gift_card_per_page] || 10)
    @gift_cards = @search_gift_card["data"]["items"]
    @search_combo = Ims::Combo.list(request, page: params[:combo_page], pagesize: params[:combo_per_page] || 10)
    @combos = @search_combo["data"]["items"]
    @search_product = Ims::Product.list(request, page: params[:product_page], pagesize: params[:product_per_page] || 10)
    @products = @search_product["data"]["items"]
    @combo = params[:combo]
    @online_num = Ims::Combo.online_num(request)[:data][:total_count] rescue 0
    @title = "商品管理"

    respond_to do |format|
      format.html{}
      format.json{render params[:gift_card_page].present? ? "gift_card_list" : (params[:product_page] ? "product_list" : "combo_list") }
    end
  end

  def update_is_online
    assistant = Ims::Assistant.update_is_online(request, {
      item_type: params[:item_type],
      item_id: params[:item_id],
      is_online: params[:is_online] == "true"
    })
    render json: {status: assistant["isSuccessful"], message: assistant["message"]}.to_json
  end

end
