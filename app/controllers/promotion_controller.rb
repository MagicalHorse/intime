class PromotionController < ApplicationController
  def index
    pid = params[:id]
    pro = Promotion.search :per_page=>1,:page=>1 do 
            query do
              match :id,pid
            end
          end
    @promotion = pro.results[0]
    return render :text => t(:commonerror), :status => 404 if @promotion.nil?
  end
  
  # list api always return json
  # input: 
  # => {page,pagesize,refreshts,sort,lng,lat}
  # => sort : 1   --- newest 3: ---neareast
  # ouput:
  # => {}
  def list
    #parse input params
    pageindex = params[:page]
    pageindex ||= 1
    pagesize = params[:pagesize]
    pagesize = [@pagesize ||=20,20].min
    is_refresh = params[:type] == 'refresh'
    refreshts = params[:refreshts]
    sort_by = params[:sort]
    sort_by ||= 1
    in_lng = params[:lng]
    in_lng ||=0
    in_lat = params[:lat]
    in_lat ||=0
    prod = []
    #search the products

      prod = Promotion.search :per_page=>pagesize, :page=>pageindex do
            query do
              match :status,1 
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
            # => starting from today
            # => starting from earlier than today still ing
            # => will start later, then by created date asc
            sort {
              by :_script=>{
                # encode the mvel expression
                :script => "
                  int mils = doc['startDate'].date.getMillis();
                  int t_mils = new java.text.SimpleDateFormat('yyyy-MM-dd').parse(startdate).getTime();
                  int t2_mils=new java.text.SimpleDateFormat('yyyy-MM-dd').parse(enddate).getTime();
                  return (mils>=t_mils && mils <t2_mils)?2:(mils>=t2_mils?0:1);",
                :type=>"number",
                 :params => {
                  "startdate"=>Date.today,
                  "enddate"=>Date.today+1.days
                  },
                :order=>"desc"
              }
              by :createdDate,'desc'
            }
          elsif sort_by.to_i == 3
            sort {
              by :_script=>{
                # encode the mvel expression
                :script => "doc['store.location'].distanceInKm(lat, lon)",
                :type=>"number",
                 :params => {
                  "lat"=>in_lat.to_f,
                  "lon"=>in_lng.to_f
                  },
                :order=>"asc"
              }
              by :createdDate,'desc'
            }
          end
        end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      default_resource = p[:resource].sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}.first
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
          :address=>p[:store][:address],
          :description=>p[:store][:description],
          :tel=>p[:store][:tel],
          :gpslat=>p[:store][:gpsLat],
          :gpslng=>p[:store][:gpsLng],
          :gpsalt=>p[:store][:gpsAlt],
          :distance=>p[:sort][0]
        },
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name],
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }]
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>pageindex,
        :pagesize=>pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/pagesize.to_f).ceil,
        :ispaged=> prod.total>pagesize,
        :promotions=>prods_hash
      }
     }.to_json()
    
  end
end