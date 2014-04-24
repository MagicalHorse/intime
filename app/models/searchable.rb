# encoding: utf-8
module Searchable
  def select_defaultresource(resource)
    default_resource = resource.select{|r| r[:type]==1}.sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}
    resource = default_resource.first
    return resource unless resource.nil?
    {
      :name=>'product/default/default',
      :width=>320,
      :height=>320
    }
  end
  def promotion_is_expire(p)
    (p[:promotion].nil?)||p[:promotion].length<1||(p[:promotion].sort{|x,y| y[:endDate].to_time<=>x[:endDate].to_time}[0][:endDate].to_time<Time.now)?false:true
  end
  def find_valid_promotions(promotions)
    promotions.select{|p| p[:status]==1 && p[:endDate].to_time>Time.now}.sort{|x,y| y[:createdDate]<=>x[:createdDate]}
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
  
  def error_500
    message = 'internal failed problem.' 
    message =  yield if block_given?
    {:isSuccessful=>false,
      :message =>message,
      :statusCode =>'500'
     }.with_indifferent_access
  end
   def success
     data_items = {}
     data_items = yield if block_given?
     {:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>data_items
     }.with_indifferent_access
   end
end
