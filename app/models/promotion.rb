# encoding: utf-8
require 'tire'
class Promotion < ActiveRecord::Base
  include Tire::Model::Search
  extend Searchable
  index_name ES_DEFAULT_INDEX
  document_type 'espromotions'
  belongs_to :store
  belongs_to :tag
  has_and_belongs_to_many :products
  has_many :comments, :as=>:source
  has_many :resources, :as=>:source
  
  def self.list_by_page(options={})
     pageindex = options[:page]
    pageindex ||= 1
    pagesize = options[:pagesize]
    pagesize = [(pagesize ||=20).to_i,20].min
    is_refresh = options[:type] == 'refresh'
    refreshts = options[:refreshts]
    sort_by = options[:sort]
    sort_by ||= 1
    in_lng = options[:lng]
    in_lng ||=0
    in_lat = options[:lat]
    in_lat ||=0
    storeid = options[:storeid]
    prod = []
    
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

    #search the products
      prod = Promotion.search :per_page=>pagesize, :page=>pageindex do
            query do
              match :status,1 
              if storeid && storeid.to_i>0
                match 'store.id',storeid
              end
              match :showInList,true
            end
            filter :range,{
              'endDate'=>{
                'gte'=>Time.now
              }
            }
          if is_refresh
            filter :range,{
              'createdDate' =>{
                'gte'=>refreshts.to_datetime
              }
            }
          end
          if sort_by.to_i == 1
            # newest order:
            # started, still going
           filter :range,{
              'startDate'=>{
                'lte'=>Time.now
              }
            }
            sort {             
              by :createdDate,'desc'
            }
          elsif sort_by.to_i == 2
            # coming soon 
            filter :range,{
              'startDate'=>{
                'gte'=>Time.now
              }
            }
            sort {             
              by :createdDate,'desc'
            }
          elsif sort_by.to_i == 3
            # nearest 
            filter :range,{
              'startDate'=>{
                'lte'=>Time.now
              }
            }
            sort {
              by '_geo_distance' => {
                'store.location'=>{
                   :lat=>in_lat.to_f,
                   :lon=>in_lng.to_f
                },
                'order'=>'asc',
                'unit'=>'km'
              }
              by :createdDate,'desc'
            }
          end
        end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      default_resource = select_defaultresource p[:resource]
      next if default_resource.nil?
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :description=>p[:description],
        :startdate=>p[:startDate],
        :enddate=>p[:endDate],
        :store_id=>p[:store][:id],
        :store=>{
          :id=>p[:store][:id],
          :name=>p[:store][:name],
          :location=>p[:store][:address],
          :description=>p[:store][:description],
          :tel=>p[:store][:tel],
          :lng=>p[:store][:location][:lon],
          :lat=>p[:store][:location][:lat],  
          :gpsalt=>p[:store][:gpsAlt],
          :distance=>p[:sort][0]
        },
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :likecount=>p[:favoriteCount]
      }
    }
    success do
      {
        :pageindex=>pageindex,
        :pagesize=>pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/pagesize.to_f).ceil,
        :ispaged=> prod.total>pagesize,
        :promotions=>prods_hash
      }
    end
    
  end
  def self.get_by_id(options={})
    pid = options[:id]
    prom = Promotion.search :per_page=>1,:page=>1 do 
            query do
              match :id,pid
            end
          end
    return error_500 if prom.total<=0
    next_gt_pid = nil
    next_lt_pid = nil
    next_gt_prod = search :per_page=>1,:page=>1 do 
            query do
              match :status,1
              
            end
            filter :range,{
                  'id' =>{
                    'gt'=>pid
                  }
                }
          end
    next_gt_pid = next_gt_prod.results[0][:id] if next_gt_prod.total>0
    next_lt_prod = search :per_page=>1,:page=>1 do 
            query do
              match :status,1
              
            end
            filter :range,{
                  'id' =>{
                    'lt'=>pid
                  }
                }
          end
    next_lt_pid = next_lt_prod.results[0][:id] if next_lt_prod.total>0
    prod_model = prom.results[0]
    success do
      {
        :id=>prod_model[:id],
        :name=>prod_model[:name],
        :description=>prod_model[:description],
        :startdate=>prod_model[:startDate],
        :enddate=>prod_model[:endDate],
        :likecount=>prod_model[:favoriteCount],
        :sharecount=>prod_model[:shareCount],
        :couponcount=>prod_model[:involvedCount],
        :favoritecount=>prod_model[:favoriteCount],
        :resources=>sort_resource(prod_model[:resource]),
        :isproductbinded=>prod_model[:isProdBindable],      
        :tag=>prod_model[:tag],
        :store=>Store.to_store_with_distace(prod_model[:store],[params[:lat]||=0,params[:lng]||=0]),
        :nextgtpid=>next_gt_pid,
        :nextltpid=>next_lt_pid
      }
    end
    
  end
  
end
