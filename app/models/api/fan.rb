# encoding: utf-8
module API
  class Fan < API::Base

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
end
