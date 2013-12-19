module Stage
  class Brand < Stage::Base
    self.collection_name = :brand

    class << self
      def group_brands
        result = get(:groupall)
        gen_data(result)
      end

      def gen_data(result)
        results = { brands: [] }
        result["data"] && result["data"].each do |brand|
          brands = []
          brand["groupval"].each do |entity|
            brands << {id: entity["id"], name: entity["name"]}
          end
          results[:brands] << {brand["groupname"] =>  brands}
        end
        results
      end
    end

  end
end
