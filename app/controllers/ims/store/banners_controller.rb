class Ims::Store::BannersController < Ims::Store::BaseController

  def index

  end

  def new

  end

  def create

  end

  def destroy
    render json: {status: true}.to_json
  end

end
