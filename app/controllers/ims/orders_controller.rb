class Ims::OrdersController < Ims::BaseController
  def new

  end

  def show
  end

  def create
    render json: {status: true, id: 1}.to_json
  end

  def payments
  end

  def change_state
    render json: {status: true, id: 1}.to_json
  end

  def cancel
  end
end