require 'auth/authenticate_system'
class ApplicationController < ActionController::Base
  before_filter :parse_params, :only=>[:list,:search]
  PAGE_ALL_SIZE = 1000
 
  protected
  def error_500
    message = 'internal failed problem.' 
    message =  yield if block_given?
    {:isSuccessful=>false,
      :message =>message,
      :statusCode =>'500'
     }.to_json()
  end
   def succ_200
    message = 'success.' 
    message =  yield if block_given?
    {:isSuccessful=>true,
      :message =>message,
      :statusCode =>'200'
     }.to_json()
  end
  def succ_compose_200
    hash_message = {:isSuccessful=>true,
      :statusCode =>'200',
      :message => 'success',
     }
    yield hash_message if block_given?
    hash_message.to_json()
  end
  def select_defaultresource(resource)
    # default_resource = resource.select{|r| r[:isDefault]==true}
    default_resource = resource.select{|r| r[:type]==1}.sort_by {|x| [x[:sortOrder].to_i]}
    default_resource.first
  end
  def select_defaultaudioresource(resource)
    resource.select{|r| r[:type]==2}.sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}.first
  end
  def sort_resource(resource)
    ensure_resources(resource).select{|r| r[:status]!=-1}.sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}
  end
  def ensure_resources(resource)
    resource.map{|r|
      new_domain = PIC_DOMAIN
      new_domain = AUDIO_DOMAIN if r[:type]==2          
      r.to_hash.merge!(:domain=>new_domain)
    }
  end
  def find_valid_promotions(promotions)
    promotions.select{|p| p[:status]==1 && p[:endDate]>Time.now}.sort{|x,y| y[:createdDate]<=>x[:createdDate]}
  end
  def parse_params
    #parse input params
    @pageindex = params[:page]
    @pageindex ||= 1
    @pagesize = params[:pagesize]
    @pagesize = [(pagesize ||=20).to_i,20].min
    @is_refresh = params[:type] == 'refresh'
    @refreshts = params[:refreshts]
  end
end
