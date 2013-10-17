module Stage
  class Store < Stage::Base
    self.collection_name = :store

    class << self
      def list
        result = get(:list)
        gen_data(result)
      end

      def gen_data(result)
        results = { stores: [] }
        result["data"] && result["data"].each do |store|
         results[:stores]  << {id: store["id"], name: store["name"]}
        end
        results
      end
    end

  end
end
