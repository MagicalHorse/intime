require "#{File.dirname(__FILE__)}/restful.rb"

module API::Address
  extend API::Restful

  class << self
    def index(req, params = {})
      post(req, params.merge(path: 'address/my'))
    end
  end
end
