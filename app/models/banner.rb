# -*- encoding : utf-8 -*-
require 'tire'
class Banner < ActiveRecord::Base
  attr_accessible :sortorder, :status
  include Tire::Model::Search
  extend Searchable

  index_name ES_DEFAULT_INDEX
  document_type 'esbanners'
  
  def self.list_by_page(options={})
   
    page_index_in = options[:page]
    page_size_in = options[:pagesize]
    page_size = (page_size_in.nil?)?40:page_size_in.to_i
    page_size = 40 if page_size>40
    page_index = (page_index_in.nil?)?1:page_index_in.to_i
    #search the special topic
    prod = search :per_page=>page_size,:page=>page_index do
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
      default_resource = select_defaultresource p[:resource]
      next if default_resource.nil?
      prods_hash << {
        :id=>p[:promotion][:id],
        :sortorder=>p[:sortOrder],
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :targetType=>2,
        :targetId=>p[:promotion][:id]
      }
    }
    success do 
      {
        :pageindex=>page_index,
        :pagesize=>page_size,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/page_size.to_f).ceil,
        :ispaged=> prod.total>page_size,
        :promotions=>prods_hash
      }
    end
  end
end
