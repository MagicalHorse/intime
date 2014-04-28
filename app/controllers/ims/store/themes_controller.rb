# encoding: utf-8
class Ims::Store::ThemesController < Ims::Store::BaseController

  def index

  end

  def edit

  end

  def update
    render json: {status: true}.to_json
  end

end
