class Ims::Store::IncomesController < Ims::Store::BaseController

  def index

  end

  def my
  end

  def new
  end

  def create
    render json: {status: true}.to_json
  end

  def list
    render :index
  end

end
