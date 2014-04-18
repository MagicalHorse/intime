class Mini::Sms < Mini::Base

  def self.send(req, params = {})
    post(req, params.merge(path: 'sms/send'))
  end

end