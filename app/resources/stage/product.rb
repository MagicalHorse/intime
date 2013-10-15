module Stage
  class Product < Stage::Base
    self.collection_name = :product

    class << self
      def fetch(id)
        new(get(id)['data'])
      end

    end

    def image_urls(size = 320)
      return [] if resources.blank?

      resources.map { |resource| [PIC_DOMAIN, resource.name, "_#{size}X0.jpg"].join('')}
    end
  end
end
