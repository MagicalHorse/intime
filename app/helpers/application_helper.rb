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
    when 'qq_connect', 'weibo', 'tqq2'
      "/auth/#{provider}"
    else
      raise ArgumentError, 'provider can only is qq_connect, weibo and tqq2.'
    end
  end
end
