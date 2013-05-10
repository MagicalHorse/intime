class V22::StorePromotionController < ApplicationController
  def list
    # if refreshts not provide but is_refresh, return empty
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>1,
        :pagesize=>0,
        :totalcount=>0,
        :totalpaged=>0,
        :ispaged=> false
      }
     } if @is_refresh == true && @refreshts.nil?
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
        :inscopenotice=>p.inScopeNotice,
        :unitperpoints=>p.unitPerPoints,
        :exchangerulemessage=>p.exchangerule_message,
        :rule=>p.exchangeRule
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>@pageindex,
        :pagesize=>@pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/@pagesize.to_f).ceil,
        :ispaged=> prod.total>@pagesize,
        :items=>prods_hash
      }
     }.to_json()
    
  end
  def detail
    param_id = params[:id]
    return render :json=>error_500 if param_id.nil?
    prod = StorePromotionES.search :per_page=>1, :page=>1 do
          query do
            match :id,param_id.to_i
          end
          
    end
    # render request
   
    p = prod.results.first
    return render :json=>error_500 if p.nil?
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
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
        :inscopenotice=>p.inScopeNotice,
          :unitperpoints=>p.unitPerPoints,
         :exchangerulemessage=>p.exchangerule_message,
        :rule=>p.exchangeRule
      }
     }.to_json()
    
  end
end
