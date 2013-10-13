module ApplicationHelper

  def small_pic_url(r)
    domain = PIC_DOMAIN 
    return domain + r[:name] +'_120x0.jpg'
  end

  def large_pic_url(r)
    domain = PIC_DOMAIN
    return domain + r[:name] +'_640x0.jpg'
  end

  def audio_url(r)
    domain = AUDIO_DOMAIN
    return domain + r[:name].gsub('\\','/')+'.mp3'
  end

  def newline_to_br(text)
    return text if text.nil?
    return simple_format(text)
  end

  def oauth_path(provider)
    case provider.to_s
    when 'qq_connect', 'weibo', 'tqq2'
      "/auth/#{provider}"
    else
      raise ArgumentError, 'provider can only is qq_connect, weibo and tqq2.'
    end
  end
end
