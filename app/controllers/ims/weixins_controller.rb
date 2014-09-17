# encoding: utf-8

class Ims::WeixinsController < Ims::BaseController

  skip_before_filter :wx_auth!
  before_filter :verify_token, only: :index
  before_filter :signature!, only: :create

  def index

  end

  def create
    render nothing: true
  end

  def login
    @title = "微信登录"
    if session[:login_key].blank? || (@img_url = begin; $memcached.get(session[:login_key]); rescue Memcached::NotFound; nil; end ).blank?
      session[:login_key] ||= rand(100000).to_s
      @img_url = Ims::Weixin.qr_url(weixin_key, session[:login_key])
      $memcached.set(session[:login_key], @img_url, 1800)
    end
  end

  protected

  def verify_token
    token = weixin_key[:token]
    timestamp = params["timestamp"]
    nonce = params["nonce"]
    echostr = params["echostr"]
    signature = params["signature"]
    # binding.pry
    if signature != Digest::SHA1.hexdigest([token, timestamp, nonce].sort.join)
      render text: "Forbidden", :status => 403
    else
      render text: echostr
    end
  end

  def signature!
    begin
      @xml_params = Hash.from_xml(request.body.read)
    rescue Exception => e
      nil
    end
    @params = request.params.merge(@xml_params) if @xml_params.is_a?(Hash)
    #render :text => "Forbidden", :status => 403 if Time.now.to_i - params[:timestamp].to_i > 5 || params[:timestamp].to_i < 0 || params[:signature] != Digest::SHA1.hexdigest([$weixin_token, params[:timestamp], params[:nonce]].sort.join)
  end

  # 开发完后要注释掉
  def weixin_key
    {
      app_id: "wxd272dd0c13f8f558",
      app_secret: "d910fecc1f532ba73d8e6cecf8a9cf3e",
      token: "2740a32bbe796401"
    }
  end

end