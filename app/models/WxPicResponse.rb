# encoding: utf-8
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
  def to_xml2
    super {|doc|
      doc.ArticleCount @ArticleCount
      doc.Articles {
        @Articles.each {|article|
          article.to_xml2 doc
         }
      }
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
  def to_xml2(doc)
    doc.item {
      doc.Title {doc.cdata! @Title}
      doc.Description {doc.cdata! @Description}
      doc.PicUrl {doc.cdata! @PicUrl}
      doc.Url {doc.cdata! @Url}
    }
  end
end
