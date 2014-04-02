class Ims::Store::SellsController < Ims::Store::BaseController

  def index
    @gift_cards = Ims::Assistant.all(request)["data"]["items"]
    @combos = Ims::Combo.list(request)["data"]["items"]
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