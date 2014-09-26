# encoding: utf-8
class Store < ActiveRecord::Base
  DOCUMENT_TYPE = "esstores"

  belongs_to :company
  belongs_to :region
  has_many :products
  has_many :promotions
  attr_accessible :address, :desc, :gpsalt, :gpslatit, :gpslngit, :latit, :lngit, :name, :status, :telephone

  extend Searchable
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type DOCUMENT_TYPE

  def self.es_search(options={})
    store_id = options[:store_id]
    group_id = options[:group_id]
    query = Jbuilder.encode do |json|
      json.filter do
        json.and do
          json.child! do
            json.term do
              json.status 1
            end
          end

          if group_id.present?
            json.child! do
              json.term do
                json.groupId group_id
              end
            end
          end

          if store_id.present?
            json.child! do
              json.term do
                json.id store_id
              end
            end
          end
        end
      end
    end
    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: 10000000, body: query
    mash = Hashie::Mash.new result
    mash.hits.hits.collect(&:_source)
  end

  class<<self
    def to_store_with_distace(store_info,from)
      store_info.to_hash.merge(:distance=>Geocoder::Calculations.distance_between(from, [store_info[:location][:lat],store_info[:location][:lon]], :units => :km).round)
    end

    def list_all
      prod = Store.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
    end
    # render request
    prods_hash = []
    prod.results.each {|p|
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :location=>p[:address],
        :tel=>p[:tel],
        :lng=>p[:location][:lon],
        :lat=>p[:location][:lat],
        :description=>p[:description]
      }
    }
    success do
      prods_hash
    end

    end

    def get_by_id(options={})
       store_id = options[:id]
      return error_500 if store_id.nil?

      #find the store
      prod = Store.search :per_page=>1,:page=>1 do
            query do
              match :id, store_id
            end
      end
      return error_500 if prod.results.length<1
      store_finded = prod.results.first
      default_resource = select_defaultresource store_finded[:resource] unless store_finded[:resource].nil?
      response_resource = {
              :domain=>PIC_DOMAIN,
              :name=>default_resource[:name].gsub('\\','/'),
              :width=>default_resource[:width],
              :height=>default_resource[:height]
              } unless default_resource.nil?
      success do
        {
            :id=>store_finded[:id],
            :name=>store_finded[:name],
            :description=>store_finded[:description],
            :englishname=>store_finded[:englishName],
            :createddate =>store_finded[:createdDate],
            :location=> store_finded[:address],
            :tel => store_finded[:tel],
            :lng => store_finded[:location][:lon],
            :lat => store_finded[:location][:lat],
            :gpslat => store_finded[:gpsLat],
            :gpsLng => store_finded[:gpsLng],
            :gpsAlt => store_finded[:gpsAlt],
            :resources=>response_resource
        }
      end

    end
  end
end
