module Stage
  class Tag < Stage::Base
    self.collection_name = :tag

    class << self
      def list
        result = get(:list)
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
