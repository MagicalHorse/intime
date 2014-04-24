# encoding: utf-8
require 'tire'
class Hotword < ActiveRecord::Base
  attr_accessible :brandid, :sortorder, :status, :type, :word
  
  extend Searchable
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'eshotwords'
  
  def self.list_all
    prod = Hotword.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
          sort {
            by :sortOrder,'desc'
          }
    end
    # render request
    words_arr = []    
    brands_arr = []  
    stores_arr = [] 
    prod.results.each {|p|
      if p[:type]==1
        # word
        words_arr<< p[:word]
      elsif p[:type] ==2
        # brand
        brands_arr<< {
          :id=>p[:brandId],
          :name=>p[:word]
        }
      elsif p[:type] ==3
        stores_arr << {
          :id=>p[:brandId],
          :name=>p[:word]
        }
      end
    }
    success do
      {
        :words=>words_arr,
        :brandwords=>brands_arr,
        :stores=>stores_arr
      }
    end
  end
end
