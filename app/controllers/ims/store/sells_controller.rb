class Ims::Store::SellsController < Ims::Store::BaseController

  def index
    @gift_cards = Ims::Giftcard.all(request)["data"]["items"]
    @combos = Ims::Combo.list(request)["data"]["items"]
  end

end