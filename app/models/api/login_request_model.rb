require "#{File.dirname(__FILE__)}/restful.rb"

module API::LoginRequest
  extend API::Restful

  def self.post(req, params = {})
    super(req, params.merge(path: 'customer/outsitelogin'))
  end
end
