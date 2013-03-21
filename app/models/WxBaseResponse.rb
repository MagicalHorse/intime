require 'active_support/builder' unless defined?(Builder)
class TestString
  def to_xml(options)
    builder = options[:builder]
    return self if builder.nil?
    key = options[:root]
    builder.tag!(key,'test',options)
    #builder.tag!(key,builder.cdata!(self),options)
  end
end
class WxBaseResponse
  attr_accessor :ToUserName, :FromUserName,:CreateTime,:MsgType,:FuncFlag
  def to_xml
     hashresponse ={:ToUserName=>@ToUserName,
     :FromUserName=>@FromUserName,
     :CreateTime=>@CreateTime,
     :MsgType=>@MsgType
     }
     yield hashresponse if block_given?
     hashresponse.to_xml :skip_instruct=>true,:skip_types=>true,:root=>'xml'
  end
  def cdata_string(in_str)
     hashresponse ={:ToUserName=>cdata_string(@ToUserName),
     :FromUserName=>cdata_string(@FromUserName),
     :CreateTime=>@CreateTime,
     :MsgType=>cdata_string(@MsgType)
     }
     #yield hashresponse if block_given?
     hashresponse.to_xml :skip_instruct=>true,:skip_types=>true,:root=>'xml'
     
  end
end