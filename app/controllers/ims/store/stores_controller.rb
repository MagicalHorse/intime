# encoding: utf-8
class Ims::Store::StoresController < Ims::Store::BaseController
  skip_filter :authenticate, only: [:my, :check]

  def index

  end

  def edit
  	@store = Ims::Store.show(request, {id: params[:id]})
    @title = "修改店铺信息"
  end

  def update
    @store_id = params[:id]
    @store = Ims::Store.update_name(request, {id: params[:id], name: params[:name]})
    @store = Ims::Store.update_mobile(request, {id: params[:id], mobile: params[:mobile]}) if @store[:isSuccessful]
  end

  def show

  end

  def check
    if current_user.store_id.present?
      redirect_to my_ims_store_store_path(id: current_user.store_id)
    else
      redirect_to ims_store_root_path
    end
  end

  def my
    if current_user.store_id.to_i == params[:id].to_i
      @can_share = true
      @store = Ims::Store.my(request)
      render :layout =>  'ims'
    else
      redirect_to ims_store_path(:id => params[:id])
    end  
  end

  def records
    @giftcards = Ims::Store.giftcard_records(request)
    @orders = Ims::Store.order_records(request)
    @title = "成交记录"
  end

  def change_logo
    @image = Ims::Store.update_logo(request, {:image => params[:img], :type => 1})
    if @image[:isSuccessful]
      json = {"status" => 1, "img" => @image[:data][:logo_full]}.to_json
    else
      json = {"status" => 0}.to_json
    end

    render :json => json
  end

  def change_info
    if params[:name] == "store_name"
      @store = Ims::Store.update_name(request, {id: params[:id], name: params[:value]})
    end

    if params[:name] == "store_phone"
      @store = Ims::Store.update_mobile(request, {id: params[:id], mobile: params[:value]})
    end

    if @store[:isSuccessful]
      json = {"status" => 1}.to_json
    else
      json = {"status" => 0}.to_json
    end

    render :json => json
  end


 #店铺管理
  def manage
    @giftcards = Ims::Store.giftcards(request)
    @combos = Ims::Store.combos(request)
  end

  def theme

  end


end