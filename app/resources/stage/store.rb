# encoding: utf-8
module Stage
  class Store < Stage::Base
    class << self
      def list
        result = ::Store.list_all()
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
        new(::Store.get_by_id({:id=>id})['data'])
      end
    end

    def image_url(size = 320)
      return nil if resources.blank?

      [PIC_DOMAIN, resources.name, "_#{size}x200.jpg"].join('')
    end
  end
end
