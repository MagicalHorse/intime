# encoding: utf-8
module Stage
  class Tag < Stage::Base
    class << self
      def list
        result = ::Tag.list_all
        gen_data(result)
      end

      def gen_data(result)
        results = { tags: [] }
        result["data"] && result["data"].each do |store|
         results[:tags]  << {id: store["id"], name: store["name"]}
        end
        results
      end
    end

  end
end
