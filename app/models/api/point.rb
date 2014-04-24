# encoding: utf-8
module API
  class Point < API::Base

    class << self
      def index(req, params={})
        post(req, params.merge(path: 'point/list'))
      end

    end
  end
end
