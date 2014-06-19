# encoding: utf-8
module API
  class Address < API::Base
    MAX_SIZE = 8

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'address/my'))
      end

      def update(req, params = {})
        post(req, params.merge(path: 'address/edit'))
      end

      def create(req, params = {})
        post(req, params.merge(path: 'address/create'))
      end

      def destroy(req, params = {})
        post(req, params.merge(path: 'address/delete'))
      end

      def detail(req, params = {})
        post(req, params.merge(path: 'address/details'))
      end
    end
  end
end
