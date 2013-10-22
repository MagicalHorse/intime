module Stage
  class Product < Stage::Base
    self.collection_name = :store

    class << self
      def fetch(id)
        new(get(:detail, id: id)['data'])
      end

    end

    def image_url(size = 320)
      return nil if resources.blank?

      [PIC_DOMAIN, resources.name, "_#{size}X0.jpg"].join('')
    end
  end
end
