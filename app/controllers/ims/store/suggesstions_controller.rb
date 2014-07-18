# encoding: utf-8

class Ims::Store::SuggesstionsController < Ims::Store::BaseController

  def new
    @title = "意见反馈"
  end

  def create
    render json: {status: true}.to_json
  end

end
