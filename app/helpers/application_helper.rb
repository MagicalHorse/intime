module ApplicationHelper

  def small_pic_url(r)
    if r.is_a?(::Hash) && (name = r[:name] || r['name']).present?
      PIC_DOMAIN + name.to_s + '_120x0.jpg'
    else
      Settings.default_image_url.product.small
    end
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

  def format_date(time)
    Time.parse(time).strftime('%Y-%m-%d') rescue nil
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

    "http://service.weibo.com/share/share.php?url=#{url}&title=#{item.name}&pic=#{item.image_urls[0]}"
  end

  def share_with_tengxun(item)
    url = case
          when item.is_a?(Stage::Promotion)
            front_promotion_url(item.id)
          when item.is_a?(Stage::Product)
            front_product_url(item.id)
          end

    "http://share.v.t.qq.com/index.php?c=share&a=index&title=#{item.name}&url=#{url}&pic=#{item.image_urls[0]}"
  end

  def format_time_range(startdate, enddate)
    [
      startdate.to_time.strftime('%Y.%m.%d'),
      enddate.to_time.strftime('%Y.%m.%d')
    ].join('-')
  end

  def display_product_brand_name(brandname, brand2name)
    if brandname.present? && brand2name.present?
      h "#{brandname}(#{brand2name})"
    elsif brandname.present?
      h brandname
    elsif brand2name.present?
      h brand2name
    end
  end

  # 显示没有数据的提示
  def display_blank_prompt(msg)
    render partial: 'front/blank_prompt', locals: { msg: msg }
  end

  # \r\n 替换成 br
  def format_newline(text)
    (h text.to_s).gsub(/\r?\n/, '<br />').html_safe
  end
end
