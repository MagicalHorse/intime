module ApplicationHelper

  def small_pic_url(r)
    PIC_DOMAIN + r[:name].to_s + '_120x0.jpg' if r.is_a?(::Hash)
  end

  def large_pic_url(r)
    PIC_DOMAIN + r[:name] +'_640x0.jpg' if r.is_a?(::Hash)
  end

  def audio_url(r)
    AUDIO_DOMAIN + r[:name].to_s.gsub('\\','/')+'.mp3' if r.is_a?(::Hash)
  end

  def newline_to_br(text)
    return text if text.nil?
    return simple_format(text)
  end

  def oauth_path(provider)
    case provider.to_s
    when 'qq_connect', 'weibo', 'tqq2','wechat'
      "/auth/#{provider}"
    else
      raise ArgumentError, 'provider can only is qq_connect, weibo and tqq2.'
    end
  end

  def static_url(path)
    "#{root_url}#{path}" if path
  end

  def format_time(time)
    Time.parse(time).strftime('%Y-%m-%d %H:%M:%S') rescue nil
  end

  def order_page?
    params[:controller] == 'front/orders'
  end

  def rma_page?
    params[:controller] == 'front/rmas'
  end

  def share_with_sina(item)
    url = case
          when item.is_a?(Stage::Promotion)
            front_promotion_url(item.id)
          when item.is_a?(Stage::Product)
            front_product_url(item.id)
          end

    "http://service.weibo.com/share/share.php?url=#{url}&title=#{item.name}&pic="
  end

  def format_time_range(startdate, enddate)
    [
      startdate.to_time.strftime('%Y/%m/%d'),
      enddate.to_time.strftime('%Y/%m/%d')
    ].join('-')
  end

  def href_of_avatar_url(avatar_url)
    avatar_url.present? ? avatar_url : CurrentUser::DEFAULT_AVATAR_URL
  end
end
