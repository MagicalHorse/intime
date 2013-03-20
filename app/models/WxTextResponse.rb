require 'WxBaseResponse'

class WxTextResponse< WxBaseResponse
  attr_accessor :Content
  def to_xml
    super {|h|
      h[:Content] = @Content
      }
  end
end
