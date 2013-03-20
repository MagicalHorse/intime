require 'WxBaseResponse'

class WxPicResponse< WxBaseResponse
  attr_accessor :ArticleCount, :Articles
  def to_xml
    super {|h|
      h[:ArticleCount] = @ArticleCount
      h[:Articles] = @Articles
      h[:FuncFlag]= self.FuncFlag
      }
  end
end

class WxPicArticle
  attr_accessor :Title, :Description, :PicUrl, :Url
  def to_xml(options)
    builder = options[:builder]
    builder.item {|i|
      i.Title {builder.cdata! @Title}
      i.Description {builder.cdata! @Description}
      i.PicUrl {builder.cdata! @PicUrl}
      i.Url {builder.cdata! @Url}
      }
  end
end