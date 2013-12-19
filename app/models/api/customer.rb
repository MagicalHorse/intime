# encoding: utf-8
module API
  class Customer < API::Base
    GENDER = { 0 => '保密', 1 => '男', 2 => '女' }

    class << self
      def show(req, params = {})
        post(req, params.merge(path: 'customer/detail'))
      end

      def his_show(req, params = {})
        post(req, params.merge(path: 'customer/daren'))
      end

      def update(req, params = {})
        post(req, params.merge(path: 'customer/detail/update'))
      end
    end
  end
end
