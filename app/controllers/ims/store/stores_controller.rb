class Ims::Store::StoresController < Ims::Store::BaseController
  
  def index
  	 
  end

  def edit
  	@store = Ims::Store.show(request, {id: params[:id]}) 
  end

  def update
  	 redirect_to ims_store_store_path(1) 
  end

  def show

  end

  def my
    @store = Ims::Store.my(request)
  end

  def records
    @giftcards = Ims::Store.giftcard_records(request) 
    @orders = Ims::Store.order_records(request)
  end

  def change_logo
    @image = Ims::Combo.upload_img(request, {:image => params[:img]})

    if @image[:isSuccessful]
      json = {"status" => 1, "img" => @image[:data][:url]}.to_json
    else
      json = {"status" => 0}.to_json
    end

    render :json => json
  end

  
end