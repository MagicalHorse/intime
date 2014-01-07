require 'dalli'
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
      
      def list_configurations
        config_cache_key = 'product_list_configurations'
        configurations = nil;
        dc = nil;
        if Rails.env.production?
          dc = Dalli::Client.new("#{Settings.elasticache.host}#{Settings.elasticache.port}", { :namespace => "i.intime.com.cn", :compress => true })
          configurations = dc.get(config_cache_key)
        end
        return configurations unless configurations.nil?
        stores   = Stage::Store.list
        brands   = Stage::Brand.group_brands[:brands]
        tags     = Stage::Tag.list
        hotwords = Stage::HotWord.list
        configurations = {:stores=>stores,:brands=>brands,:tags=>tags,:hotwords=>hotwords}
        if Rails.env.production?
          dc = Dalli::Client.new("#{Settings.elasticache.host}#{Settings.elasticache.port}", { :namespace => "i.intime.com.cn", :compress => true }) if dc.nil?
          dc.set(config_cache_key,configurations,1.hour)
        end
        configurations
      end
    end

    def image_urls(size = 320)
      return [] if resources.blank?

      resources.map { |resource| [PIC_DOMAIN, resource.name, "_#{size}x0.jpg"].join('')}
    end
  end
end
