class Ims::CardOrdersController < Ims::BaseController
  skip_before_filter :wx_auth!

  def create
    params[:type]
    params[:num]
  end

  def show
    @price = 500
    @code = 'AF135GBGQS'
  end

end