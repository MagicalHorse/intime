# encoding: utf-8
module Stage
  class Promotion < Stage::Base
    class << self
      def list(options = {})
        default_options = { page: 1, pagesize: 10, sort: 1, client_version: '2.3' }
        options = default_options.merge(options.delete_if {|k, v| v.blank?})

        raw_data = ::Promotion.list_by_page(options)['data']

        promotions = raw_data['promotions'].inject([]) do |_r, _p|
          _r << self.new(_p)
          _r
        end

        Kaminari.paginate_array(
          promotions,
          total_count: raw_data['totalcount'].to_i
        ).page(raw_data['pageindex']).per(raw_data['pagesize'])
      end

      def fetch(id)
        new(::Promotion.get_by_id({:id=>id})['data'])
      end


    end

    def image_urls(size = 320)
      return [] if resources.blank?

      result = []
      resources.each do |resource|
        if resource.respond_to?(:type)
          next unless resource.type.to_i == 1

          result << [PIC_DOMAIN, resource.name, "_#{size}x0.jpg"].join('')
        else
          result << [PIC_DOMAIN, resource.name, "_#{size}x0.jpg"].join('')
        end
      end
      result
    end
  end
end
