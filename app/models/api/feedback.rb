# encoding: utf-8
module API
  class Feedback < API::Base
    
    class << self
      def create(req, params = {})
        post(req, params.merge(path: 'feedback/create'))
      end
    end
  end
end
