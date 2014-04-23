# encoding: utf-8
class Ims::Store::StoresController < Ims::Store::BaseController
  skip_filter :authenticate, only: [:my, :check]
  before_filter :is_my_store, only: [:edit, :update, :my]

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
      redirect_to my_ims_store_store_path(id: current_user.store_id, :t => Time.now.to_i)
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
      redirect_to ims_store_path(:id => params[:id], t: Time.now.to_i)
    end
  end

  def records
    @search_gift_card = Ims::Store.giftcard_records(request, page: params[:gift_card_page] || 1, pagesize: params[:gift_card_per_page] || 10)
    @gift_cards = @search_gift_card["data"]["items"]
    @search_order = Ims::Store.order_records(request, page: params[:order_page] || 1, pagesize: params[:order_per_page] || 10)
    @orders = @search_order["data"]["items"]
    @title = "交易记录"

    respond_to do |format|
      format.html{}
      format.json{render params[:gift_card_page].present? ? "gift_card_list" : "order_list" }
    end
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

  private
  def is_my_store
    redirect_to ims_store_path(:id => params[:id]) unless current_user.store_id.to_i == params[:id].to_i
  end


end