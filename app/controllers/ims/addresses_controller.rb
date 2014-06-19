# encoding: utf-8

class Ims::AddressesController < Ims::BaseController

  before_filter :provinces, only:[:new, :edit]

  def index
    @search = API::Address.index(request, page: params[:page], pagesize: params[:per_page] || 10)
    @addresses = @search["data"]["items"]
    @addresses = [{id: 1, shippingperson: '张先生', shippingphone: "13581575435", shippingprovince: "山西", shippingcity: "吕梁", shippingdistrict: "文水", shippingaddress: "××街道××房间", shippingzipcode: "100025"}]
    @title = "我的地址"
  end

  def new
    @title = "添加地址"
  end

  def edit
    @address = API::Address.detail(request, {id: params[:id]})[:data]
    @provinces = API::Environment.supportshipments(request)[:data][:items]
    cities = @provinces.find{|province| province[:provinceid] == @address[:shippingprovinceid]}[:items]
    @cities = cities.collect{|city| [city[:cityname], city[:cityid]]}
    @districts = cities.find{|city| city[:cityid] == @address[:shippingcityid]}[:items].collect{|district| [district[:districtname], district[:districtid]]}
  end

  def create
    @address = API::Address.create(request, params[:address])
    if @address[:isSuccessful]
      redirect_to ims_addresses_path
    else
      redirect_to new_ims_address_path
    end
  end

  def update
    @address = API::Address.update(request, params[:address])
    if @address[:isSuccessful]
      redirect_to ims_addresses_path
    else
      redirect_to edit_ims_address_path(params[:id])
    end
  end

  def destroy
  end

  def list
    @provinces = API::Environment.supportshipments(request)[:data][:items]
    if !(province_id = params[:province_id].to_i).zero?
      render json: {data: @provinces.find{|province| province[:provinceid] == province_id}[:items]}.to_json
    elsif !(city_id = params[:city_id].to_i).zero?
      province = @provinces.find{|province| province[:items].collect{|p| p[:cityid]}.include?(city_id) }
      render json: {data: province[:items].find{|city| city[:cityid] == city_id}[:items]}.to_json
    end
  end

  protected

  def provinces
    @provinces = API::Environment.supportshipments(request)[:data][:items]
  end

end