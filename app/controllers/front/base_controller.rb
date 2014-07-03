# encoding: utf-8
class Front::BaseController < ApplicationController
  layout 'front'
  helper_method :current_user, :signed_in?, :gen_user_logo, :format_newline,:oauth_path

  def current_user
    @current_user ||= session[:current_user]
  end

  def signed_in?
    !!current_user
  end

  def authenticate!
    return true if signed_in?

    auth_path = login_path
    auth_path = oauth_path('wechat') if wechat_request?
    if request.xhr?
      session[:return_to] = request.referrer
      render js: "window.location='#{auth_path}?return_to=#{Rack::Utils.escape(request.referrer)}'"

    else
      session[:return_to] = request.original_url
      redirect_to("#{auth_path}?return_to=#{Rack::Utils.escape(request.original_url)}") and return
    end
  end

  def wechat_login
=begin
    if signed_in? && !request.xhr?
      result = API::Customer.show(request)
      result[:data] ||= {}
      result[:data][:access_token]  = current_user.access_token
      result[:data][:refresh_token] = current_user.refresh_token
      set_current_user(result[:data])
      logger.info("-----> update current_user #{current_user.attributes}")
    end
=end
  end

  def render_datas(datas, options = nil)
    result = {
      page:       datas.current_page,
      pagesize:   datas.limit_value,
      totalcount: datas.total_count,
      totalpaged: datas.total_pages,
      datas:      datas
    }

    result.merge!(options.delete_if {|k,v| v.blank? }) if options.present?

    render json: result.to_json, callback: params[:callback]
  end

  def format_items(data, *except_keys)
    result = {
      page:       data[:pageindex],
      pagesize:   data[:pagesize],
      totalcount: data[:totalcount],
      totalpaged: data[:totalpaged],
      datas:      data[:items]
    }

    result.except(*except_keys)
  end

  def render_items(data, options = nil)
    render json: format_items(data, options), callback: params[:callback]
  end

  protected

  def set_current_user(value)
    /^__(?<provider>[0-3])(?<uid>.*)$/ =~ value['name']
    @current_user = CurrentUser.new(
      :email              => value['email'],
      :level              => value['level'],
      :nickie             => value['nickname'],
      :id                 => value['id'],
      :provider           => provider.present? ? provider.to_i : nil,
      :isbindcard         => value['isbindcard'],
      :mobile             => value['mobile'],
      :avatar_url         => href_of_avatar_url(value['logo']),
      :coupon_count       => value['coupontotal'],
      :point              => value['pointtotal'],
      :like_count         => value['liketotal'],
      :fans_count         => value['likedtotal'],
      :favor_count        => value['favortotal'],
      :onlinecoupontotal  => value['onlinecoupontotal'],
      :offlinecoupontotal => value['offlinecoupontotal'],
      :access_token       => value['access_token'],
      :refresh_token      => value['refresh_token'],
      :level              => value['level']
    )

    set_login_cookie

    session[:current_user] = @current_user
    session[:user_token]   = value[:token]
  end

  def set_anonymous_user
    @current_user = nil
    session[:current_user] = nil
    session[:user_token]   = nil

    clear_login_cookie
  end

  def clear_login_cookie
    cookies[:login] = nil
  end

  def set_login_cookie
    cookies[:login] = {
      value:    current_user.nickie,
      domain:   Settings.domain,
      path:     '/',
      expires:  Time.now.end_of_day
    }
  end

  def gen_user_logo(logo)
    logo.to_s + '_100x100.jpg' if logo.present?
  end

  # \r\n 替换成 br
  def format_newline(text)
    (ERB::Util.html_escape text.to_s).gsub(/\r?\n/, '<br />').html_safe
  end

  def change_time_zone(time)
    time.to_time.in_time_zone('Beijing')
  end

  # http://detectmobilebrowsers.com/
  def mobile_request?
    /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.match(request.user_agent) ||
      /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.match(request.user_agent[0..3])
  end

  def wechat_request?
    mobile_request? && /MicroMessenger/i.match(request.user_agent)
  end

  def oauth_path(provider)
    case provider.to_s
    when 'qq_connect', 'weibo', 'tqq2','wechat'
      "/auth/#{provider}"
    else
      raise ArgumentError, 'provider can only is qq_connect, weibo and tqq2.'
    end
  end
end
