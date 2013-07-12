require "#{File.dirname(__FILE__)}/restful.rb"
module API::LoginRequest
    extend API::Restful
    def self.resource_name
      'customer/outsitelogin'
    end
end