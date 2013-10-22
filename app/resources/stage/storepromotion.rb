module Stage
  class Storepromotion < Stage::Base
    self.collection_name = :storepromotion

    class << self
      def list(options = {})
        default_options = { page: 1, pagesize: 10, client_version: '2.3' }
        options = default_options.merge(options.delete_if {|k, v| v.blank?})

        raw_data = get(:list, options)['data']

        promotions = raw_data['items'].inject([]) do |_r, _p|
          _r << self.new(_p)
          _r
        end

        Kaminari.paginate_array(promotions, total_count: raw_data['totalcount'].to_i).page(raw_data['pageindex']).per(raw_data['pagesize'])
      end

      def fetch(id)
        new(get(:detail, id: id, client_version: '2.3')['data'])
      end
    end

  end
end
