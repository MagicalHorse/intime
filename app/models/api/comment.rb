module API
  class Comment < API::Base
    
    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'comment/list'))
      end

      def create(req, params = {})
        post(req, params.merge(path: 'comment/create'))
      end
    end
  end
end
