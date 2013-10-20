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

      def fetch(id)
        new(get(:detail, id: id)['data'])
      end
    end

    def image_urls(size = 320)
      return [] if resources.blank?

      resources.map { |resource| [PIC_DOMAIN, resource.name, "_#{size}X0.jpg"].join('')}
    end
  end
end
