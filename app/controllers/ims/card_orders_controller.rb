class Ims::CardOrdersController < Ims::BaseController

  def create
    params[:type]
    params[:num]
  end

  def show
    @price = 500
    @code = 'AF135GBGQS'
  end

end