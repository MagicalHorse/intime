# encoding: utf-8
require 'builder'
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
  def to_xml2
    doc = Builder::XmlMarkup.new(:target=>out_str="",:indent=>0,:skip_types=>true)
    doc.xml {
      doc.ToUserName {doc.cdata! @ToUserName}
      doc.FromUserName {doc.cdata! @FromUserName}
      doc.CreateTime @CreateTime
      doc.MsgType {doc.cdata! @MsgType}
      
      yield doc if block_given?
      doc.FuncFlag @FuncFlag
    }
    out_str
  end
end
