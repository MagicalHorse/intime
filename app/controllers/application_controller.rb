# encoding: utf-8
require 'auth/authenticate_system'
class ApplicationController < ActionController::Base
  before_filter :parse_params, :only=>[:list,:search]
  after_filter :set_no_cache
  helper_method :middle_pic_url, :href_of_avatar_url, :default_product_pic_url
  
  # def default_url_options
  #   Settings.default_url_options.to_hash
  # end

  def href_of_avatar_url(avatar_url)
    if avatar_url.present? && avatar_url =~ /\d+x\d+\.jpg$/i
      avatar_url
    elsif avatar_url.present?
      "#{avatar_url}_100x100.jpg"
    else
      Settings.default_image_url.user
    end
  end

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
    default_resource = resource.select{|r| r[:type]==1}.sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}
    resource = default_resource.first
    return resource unless resource.nil?
    {
      :name=>'product/default/default',
      :width=>320,
      :height=>320
    }
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
    promotions.select{|p| p[:status]==1 && p[:endDate].to_time>Time.now}.sort{|x,y| y[:createdDate]<=>x[:createdDate]}
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

  def render_items(datas, options = nil)
    pagesize = params[:pageSize].to_i > 0 ? params[:pageSize].to_i : 20
    page     = params[:page].to_i > 0 ? params[:page].to_i : 1

    result = {
      page:       page,
      pagesize:   pagesize,
      totalcount: 100,
      totalpaged: 100/pagesize,
      datas: datas
    }

    result.merge!(options.delete_if {|k,v| v.blank? }) if options.present?

    render json: result.to_json, callback: params[:callback]
  end

  # TODO
  def render_item
  end

  def render_500(format = :json)
    if format.to_sym == :json
      message = block_given? ? yield : 'internal failed problem.'
      render json: { isSuccessful: false, message: message, statusCode: 500 }
    else
      render file: "#{Rails.root}/public/500.html", status: 500, layout: false
    end
  end

  def render_404(format = :json)
    if format.to_sym == :json
      message = block_given? ? yield : 'not found.'
      render json: { isSuccessful: false, message: message, statusCode: 404 }
    else
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false
    end
  end

  def middle_pic_url(r)
    if r.is_a?(::Hash) && (name = r[:name] || r['name']).present?
      PIC_DOMAIN + name.to_s + '_320x0.jpg'
    else
      Settings.default_image_url.product.middle
    end
  end

  def default_product_pic_url
    Settings.default_image_url.product.middle
  end
  
  def set_no_cache
    expires_now
  end
end
