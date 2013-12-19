module Stage
  class Product < Stage::Base
    self.collection_name = :product

    class << self
      def fetch(id)
        new(get(id)['data'])
      end

      def list(options = {})
        get(:list, options)
      end

      def search(options = {})
        get(:search, options)
      end

      def item_list(options = {})

        raw_data = list(options)['data']

        products = raw_data['products'].inject([]) do |_r, _p|
          _r << self.new(_p)
          _r
        end

        Kaminari.paginate_array(
          products,
          total_count: raw_data['totalcount'].to_i
        ).page(raw_data['pageindex']).per(raw_data['pagesize'])
      end

    end

    def image_urls(size = 320)
      return [] if resources.blank?

      resources.map { |resource| [PIC_DOMAIN, resource.name, "_#{size}x0.jpg"].join('')}
    end
  end
end
