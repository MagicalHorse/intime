class Store < ActiveRecord::Base
  belongs_to :company
  belongs_to :region
  has_many :products
  has_many :promotions
  attr_accessible :address, :desc, :gpsalt, :gpslatit, :gpslngit, :latit, :lngit, :name, :status, :telephone
  
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esstores'
  
  class<<self
    def to_store_with_distace(store_info,from)
      store_info.to_hash.merge(:distance=>Geocoder::Calculations.distance_between(from, [store_info[:location][:lat],store_info[:location][:lon]], :units => :km).round)
    end
  end
end
