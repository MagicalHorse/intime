# encoding: utf-8
module Stage
  class HotWord < Stage::Base
    class << self
      def list
        result = ::Hotword.list_all
        gen_data(result)
      end

      def gen_data(result)
        results = {}
        results[:words]      = result["data"]["words"]
        results[:brandwords] = result["data"]["brandwords"]
        results[:storewords] = result["data"]["stores"]
        results
      end
    end

  end
end
