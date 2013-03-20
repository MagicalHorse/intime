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
end