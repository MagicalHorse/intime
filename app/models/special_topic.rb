# encoding: utf-8
require 'tire'

class SpecialTopic < ActiveRecord::Base
  attr_accessible :desc, :name, :status
  extend Searchable
   include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esspecialtopics'
  
  def self.list_by_page(options={})
    pageindex = options[:page]
    pageindex ||= 1
    pagesize = options[:pagesize]
    pagesize = [(pagesize ||=20).to_i,20].min
    is_refresh = options[:type] == 'refresh'
    refreshts = options[:refreshts]
    
    # if refreshts not provide but is_refresh, return empty
    return success do
    {
        :pageindex=>1,
        :pagesize=>0,
        :totalcount=>0,
        :totalpaged=>0,
        :ispaged=> false
      }
    end if is_refresh == true && refreshts.nil?
    
    #search the special topic
    prod = SpecialTopic.search :per_page=>pagesize, :page=>pageindex do
          query do
            match :status,1
          end
          if is_refresh
            filter :range,{
              'createdDate' =>{
                'gte'=>refreshts.to_datetime
              }
            }
          end
          sort {
            by :createdDate, 'desc'
          }
    end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      default_resource = select_defaultresource p[:resource]
      next if default_resource.nil?
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :descriptio=>p[:description],
        :createddate =>p[:createdDate],
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :targetType=>p[:type],
        :targetId=>p[:targetValue]
      }
    }
    success do
      {
        :pageindex=>pageindex,
        :pagesize=>pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/pagesize.to_f).ceil,
        :ispaged=> prod.total>pagesize,
        :specialtopics=>prods_hash
      }
    end
   
  end
end
