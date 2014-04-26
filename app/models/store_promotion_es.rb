# encoding: utf-8
require 'tire'
require 'json'
class StorePromotionES
  extend Searchable
  include Tire::Model::Persistence
  index_name ES_DEFAULT_INDEX
  document_type 'esstorepromotions'
  property :name
  property :description
  property :createDate
  property :activeStartDate
  property :activeEndDate
  property :couponStartDate
  property :couponEndDate
  property :notice
  property :minPoints
  property :usageNotice
  property :inScopeNotice
  property :promotionType
  property :acceptPointType
  property :status
  property :createUser
  property :exchangeRule
  property :unitPerPoints
  
  def exchangerule_message
    I18n.t(:exchangeruletemplate).sub('[minpoints]',self.minPoints.to_s).sub('[unitperpoints]',self.unitPerPoints.to_s)
  end
  
  def self.list_by_page(options={})
      @pageindex = options[:page]
    @pageindex ||= 1
    @pagesize = options[:pagesize]
    @pagesize = [(pagesize ||=20).to_i,20].min
    @is_refresh = options[:type] == 'refresh'
    @refreshts = options[:refreshts]
     # if refreshts not provide but is_refresh, return empty
    return success do
      {
        :pageindex=>1,
        :pagesize=>0,
        :totalcount=>0,
        :totalpaged=>0,
        :ispaged=> false
      }
      end  if @is_refresh == true && @refreshts.nil?
    #search the special topic
    prod = StorePromotionES.search :per_page=>@pagesize, :page=>@pageindex do
          query do
            match :status,1
            match :promotionType,1
            match :acceptPointType,1
          end
          filter :range,{
              'activeStartDate' =>{
                'lte'=>Time.now.utc
              }
            }
          filter :range, {
            'activeEndDate' =>{
                'gte'=>Time.now.utc
              }
          }
          if @is_refresh
            filter :range,{
              'createDate' =>{
                'gte'=>@refreshts.to_datetime.utc
              }
            }
          end
          sort {
            by :createDate, 'desc'
          }
    end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      
      prods_hash << {
        :id=>p.id,
        :name=>p.name,
        :des=>p.description,
        :createddate =>p.createDate,
        :activestartdate => p.activeStartDate,
        :activeenddate=> p.activeEndDate,
        :couponstartdate =>p.couponStartDate,
        :couponenddate =>p.couponEndDate,
        :notice=>p.notice,
        :minpoints=>p.minPoints,
        :usagenotice=>p.usageNotice,
        :inscopenotice=>JSON.parse(p.inScopeNotice),
        :unitperpoints=>p.unitPerPoints,
        :exchangerulemessage=>p.exchangerule_message,
        :rule=>JSON.parse(p.exchangeRule)
      }
    }
    success do
      {
        :pageindex=>@pageindex,
        :pagesize=>@pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/@pagesize.to_f).ceil,
        :ispaged=> prod.total>@pagesize,
        :items=>prods_hash
      }
    end
     
  end
  def self.get_by_id(options={})
    param_id = options[:id]
    return error_500 if param_id.nil?
    prod = search :per_page=>1, :page=>1 do
          query do
            match :id,param_id.to_i
          end
          
    end

    p = prod.results.first
    return error_500 if p.nil?
    success do
      {
         :id=>p.id,
        :name=>p.name,
        :des=>p.description,
        :createddate =>p.createDate,
        :activestartdate => p.activeStartDate,
        :activeenddate=> p.activeEndDate,
        :couponstartdate =>p.couponStartDate,
        :couponenddate =>p.couponEndDate,
        :notice=>p.notice,
        :minpoints=>p.minPoints,
        :usagenotice=>p.usageNotice,
        :inscopenotice=>JSON.parse(p.inScopeNotice),
          :unitperpoints=>p.unitPerPoints,
         :exchangerulemessage=>p.exchangerule_message,
        :rule=>JSON.parse(p.exchangeRule)
      }
    end
    
  end
end
