# encoding: utf-8
class Mini::Store::BannersController < Mini::Store::BaseController

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
