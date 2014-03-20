class Ims::Store::SuggesstionsController < Ims::Store::BaseController

  def new

  end

  def create
    render json: {status: true}.to_json
  end

end