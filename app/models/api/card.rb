# encoding: utf-8
module API
  class Card < API::Base
    
    class << self
      def bind(req, params = {})
        post(req, params.merge(path: 'card/bind'))
      end

      def detail(req, params = {})
        post(req, params.merge(path: 'card/detail'))
      end
    end
  end
end
