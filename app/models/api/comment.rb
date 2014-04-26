# encoding: utf-8
module API
  class Comment < API::Base

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'comment/list'))
      end

      def create(req, params = {})
        post(req, params.merge(path: 'comment/create'))
      end

      def my_comments(req, params = {})
        post(req, params.merge(path: 'comment/my'))
      end
    end
  end
end
