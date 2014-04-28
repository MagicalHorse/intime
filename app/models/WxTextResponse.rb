# encoding: utf-8
require 'WxBaseResponse'

class WxTextResponse< WxBaseResponse
  attr_accessor :Content
  def to_xml
    super {|h|
      h[:Content] = @Content
      h[:FuncFlag] = 0
      }
  end
  def to_xml2
    super {|doc|
      doc.Content {doc.cdata! @Content}
    }   
  end
end
