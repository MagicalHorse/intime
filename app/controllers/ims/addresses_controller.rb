# encoding: utf-8

class Ims::AddressesController < Ims::BaseController

  before_filter :provinces, only:[:new, :edit, :list]
  before_filter :verify_weixin_user_access_token, :weixin_key, only: :index

  def index
    @search = API::Address.index(request)
    @addresses = @search["data"]["items"]
    @redirect_url = params[:redirect_url]
    @title = "我的地址"
    if is_mobile
      @timeStamp_val = Time.now.to_i
      @nonceStr_val = ("a".."z").to_a.sample(9).join('')
      sign = {
        accesstoken: cookies[:user_access_token],
        appid: @weixin_key[:app_id],
        noncestr: @nonceStr_val,
        timestamp: @timeStamp_val,
        url: request.referer || request.original_url
      }
      string1 = ""; sign.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
      @addrSign_val = Digest::SHA1.hexdigest(string1)
    end

    respond_to do |format|
      format.html{}
      format.json{render "index"}
    end
  end

  def new
    @title = "添加地址"
    respond_to do |format|
      format.html{}
      format.json{render "new"}
    end
  end

  def edit
    @address = API::Address.detail(request, {id: params[:id]})[:data]
    cities = @provinces.find{|province| province[:provinceid] == @address[:shippingprovinceid]}[:items]
    @cities = cities.collect{|city| [city[:cityname], city[:cityid]]}
    @districts = cities.find{|city| city[:cityid] == @address[:shippingcityid]}[:items].collect{|district| [district[:districtname], district[:districtid]]}
    @title = "编辑地址"
    respond_to do |format|
      format.html{}
      format.json{render "edit"}
    end
  end

  def show
    @address = API::Address.detail(request, {id: params[:id]})[:data]
    render json: {status: true, name: @address[:shippingperson], zipcode: @address[:shippingzipcode], phone: @address[:shippingphone], detail_address: @address[:displayaddress]}
  end

  def create
    @address = API::Address.create(request, params[:address])
    respond_to do |format|
      format.html{
        if @address[:isSuccessful]
          redirect_to ims_addresses_path
        else
          redirect_to new_ims_address_path
        end
      }
      format.json{
        render json: {status: @address[:isSuccessful], message: @address[:message]}
      }
    end
  end

  def update
    @address = API::Address.update(request, params[:address])
    respond_to do |format|
      format.html{
        if @address[:isSuccessful]
          redirect_to ims_addresses_path
        else
          redirect_to edit_ims_address_path(params[:id])
        end
      }
      format.json{
        render json: {status: @address[:isSuccessful], message: @address[:message]}
      }
    end
  end

  def destroy
    @address = API::Address.destroy(request, {id: params[:id]})
    respond_to do |format|
      format.html{
        redirect_to ims_addresses_path
      }
      format.json{
        render json: {status: @address[:isSuccessful]}
      }
    end
  end

  def list
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