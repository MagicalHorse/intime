class API::Sms < API::Base

  def self.send(req, params = {})
    post(req, params.merge(path: 'ims/sms/send'))
  end

end