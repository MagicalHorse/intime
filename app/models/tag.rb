require 'tire'
class Tag < ActiveRecord::Base
  attr_accessible :desc, :name, :sortorder, :status
  has_many :products
  
  extend Searchable
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'estags'
  
  def self.list_all()
    prod = Tag.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
          sort {
            by :sortOrder,'desc'
          }
    end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :description=>p[:description],
        :sortorder=>p[:sortOrder]
      }
    }
    success do
      prods_hash
    end
   
  end
end
