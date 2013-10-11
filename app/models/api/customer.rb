require "#{File.dirname(__FILE__)}/restful.rb"

module API::Customer
  extend API::Restful

  class << self
    def show(req, params = {})
      post(req, params.merge(path: 'customer/detail'))
    end
  end
end
