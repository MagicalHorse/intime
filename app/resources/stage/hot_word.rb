module Stage
  class HotWord < Stage::Base
    self.collection_name = :hotword

    class << self
      def list
        result = get(:list)
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
