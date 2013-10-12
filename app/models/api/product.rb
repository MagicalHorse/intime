require "#{File.dirname(__FILE__)}/restful.rb"

module API::Product
  extend API::Restful

  class << self

    #sourcetype: 1喜欢, 2促销
    def my_favorite(req, params = {})
      post(req, params.merge(path: 'favorite/my'))
    end

    def my_share_list(req, params = {})
      post(req, params.merge(path: 'items/list'))
    end

  end
end
