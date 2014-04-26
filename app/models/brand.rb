# encoding: utf-8
require 'tire'
class Brand < ActiveRecord::Base
  DOCUMENT_TYPE = "esbrands"
  attr_accessible :desc, :englishname, :logo, :name, :status, :website
  has_many :products
  has_many :promotions

  include Tire::Model::Search
  extend Searchable
  index_name ES_DEFAULT_INDEX
  document_type DOCUMENT_TYPE


  def self.es_search(options={})
    result = $client.search index: ES_DEFAULT_INDEX, type: DOCUMENT_TYPE, size: 10000000
    mash = Hashie::Mash.new result
    mash.hits.hits.collect(&:_source)
  end

  def self.list_all
    prod = search :per_page=>PAGE_ALL_SIZE do
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
        :website=>p[:website],
        :description=>p[:description],
        :log=>p[:logo],
      }
    }
    success do
      prods_hash
    end

  end

  def self.list_by_group
     prod = Brand.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
          sort {
            by :group
          }
    end
    # render request
    group_hash = {}
    prod.results.each {|p|
      group_value = p[:group]
      group_value ||= '#'
      group_value.upcase!
      group_hash[group_value]=[] if !(group_hash.has_key?(group_value))
      group_hash[group_value]<<{
        :id=>p[:id],
        :name=>p[:name],
        :englishname=>p[:englishName],
        :group=>p[:group],
        :website=>p[:website],
        :description=>p[:description],
        :log=>p[:logo]
      }
    }
    prods_hash = []
    group_hash.each do |key,value|
      prods_hash<<{
        :groupname=>key,
        :groupval=>value
      }
    end
    success do
      prods_hash
    end

  end

end
