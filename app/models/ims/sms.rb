# encoding: utf-8
class Ims::Sms < Ims::Base

  def self.send(req, params = {})
    post(req, params.merge(path: 'sms/send'))
  end

end
