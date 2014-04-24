# encoding: utf-8
module API
  class Rma < API::Base
    STATUSES = {
      new: 1,         # 新创建
      approval: 2,    # 审核通过，可看邮寄地址
      completed: 10,  # 退货完成
      cancelled: -10  # 取消
    }

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'rma/list'))
      end

      def create(req, params = {})
        post(req, params.merge(path: 'order/rma'))
      end

      def show(req, params = {})
        post(req, params.merge(path: 'rma/detail'))
      end

      def order_index(req, params = {})
        post(req, params.merge(path: 'rma/orderlist'))
      end

      def update(req, params = {})
        post(req, params.merge(path: 'rma/update'))
      end

      def destroy(req, params = {})
        post(req, params.merge(path: 'rma/void'))
      end
    end
  end
end
