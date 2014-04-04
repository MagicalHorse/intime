class Ims::Store::SellsController < Ims::Store::BaseController

  def index
    @search_gift_card = Ims::Giftcard.all(request, page: params[:gift_card_page], pagesize: params[:gift_card_per_page])
    @gift_cards = @search_gift_card["data"]["items"]
    @search_combo = Ims::Combo.list(request, page: params[:combo_page], pagesize: params[:combo_per_page])
    @combos = @search_combo["data"]["items"]
    respond_to do |format|
      format.html{}
      format.json{render params[:gift_card_page].present? ? "gift_card_list" : "combo_list" }
    end
  end

  def update_is_online
    assistant = Ims::Assistant.update_is_online(request, {
      storied: params[:store_id],
      item_type: params[:item_type],
      item_id: params[:item_id],
      is_online: params[:is_online] == "true"
    })
    render json: {status: assistant["isSuccessful"]}.to_json
  end

end