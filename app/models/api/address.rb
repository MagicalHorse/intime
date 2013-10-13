require "#{File.dirname(__FILE__)}/restful.rb"

module API::Address
  extend API::Restful

  class << self
    def index(req, params = {})
      post(req, params.merge(path: 'address/my'))
    end

    def update(req, params = {})
      post(req, params.merge(path: 'address/update'))
    end

    def create(req, params = {})
      post(req, params.merge(path: 'address/create'))
    end

    def destory(req, params = {})
      post(req, params.merge(path: 'address/delete'))
    end
  end
end
