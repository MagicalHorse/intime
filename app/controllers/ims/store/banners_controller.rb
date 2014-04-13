# encoding: utf-8
class Ims::Store::BannersController < Ims::Store::BaseController

  def index

  end

  def new

  end

  def create
    render json: {status: true}.to_json
  end

  def destroy
    render json: {status: true}.to_json
  end

end
