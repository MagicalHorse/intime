# encoding: utf-8
module API
  class Follow < API::Base

    class << self
      # type: 0-获取我关注列表 1-获取关注我列表 userId：关注人的主键 
      def follows(req, params={})
        post(req, params.merge(path: 'like/list'))
      end

      # likeduserid
      def follow(req, params={})
        post(req, params.merge(path: 'like/create'))
      end

      def unfollow(req, params={})
        post(req, params.merge(path: 'like/destroy'))
      end

    end
  end
end
