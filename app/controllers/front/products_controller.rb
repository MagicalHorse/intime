# encoding: utf-8
class Front::ProductsController < Front::BaseController
  before_filter :authenticate!, only: [:favor, :unfavor, :download_coupon, :comment]

  def show
    @product = Stage::Product.fetch(params[:id])

    @product_info = API::Product.availoperation(request, productid: params[:id])['data']
  end

  def index
    if params[:storeid].present?
      @info = ["store", params[:storeid]]
    elsif params[:promotionid].present?
      @info = ["promotionid", params[:promotionid]]
    elsif params[:topicid].present?
      @info = ["topicid", params[:topicid]]
    elsif params[:brandid].present?
      @info = ['brand', params[:brandid]]
    else
      @info = ['0', '0']
    end
  end

  def his_favorite_api
    options = {
      page: params[:page],
      pagesize: 10,
      sourcetype: params[:loveType],
      userid:     params[:userid]
    }
    if options[:sourcetype] == "3"
      result = API::Product.my_share_list(request, options)
    else
      result  = API::Product.his_favorite(request, options)
    end
    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_data(result["data"]["items"], options[:sourcetype]))
    render :json =>results.to_json , callback: params[:callback]
  end

  def search_api
    options = {
      page: params[:page],
      pagesize: 10,
      term: params[:term]
    }
    result  = Stage::Product.search(options)
    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_search_data(result["data"]["products"]))
    render :json =>results.to_json , callback: params[:callback]
  end

  def list
    configurations = Stage::Product.list_configurations
    @stores   = configurations[:stores]
    @brands   = configurations[:brands]
    @tags     = configurations[:tags]
    @hotwords = configurations[:hotwords]
    @all_brands = @brands.map{|b| b.values}.flatten 
    @brand_keys = @brands.map{|b| b.keys}.flatten 
  end

  def sort_list
  end

  def get_group_brands(brands)
    result = {}
    ('A'..'Z').to_a.each do |character|
      brand_array = brands[:brands].select{|brand| brand[character] }
      if brand_array.present?
        result[character] = brand_array.first[character]
      end
    end
    result
  end

  def list_api
    options = {
      page: params[:page],
      pagesize: 10
    }
    options.merge!(covert_options_for_search(params[:type], params[:entity_id]))
    result  = Stage::Product.list(options)
    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_data(result["data"]["products"]))
    render :json =>results.to_json , callback: params[:callback]
  end

  def my_favorite_api
    options = {
      page: params[:page],
      pagesize: 10,
      sourcetype: params[:loveType]
    }

    if options[:sourcetype] == "3"
      result = API::Product.my_share_list(request, options)
    else
      result  = API::Product.my_favorite(request, options)
    end

    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_data(result["data"]["items"], options[:sourcetype]))
    render :json =>results.to_json , callback: params[:callback]
  end

  #当传userid时 是他的分享，没传是当前用户的分享
  def my_share_list_api
    options = {
      page: params[:page],
      pagesize: 10,
      userid: params[:userid]
    }
    
    result = API::Product.my_share_list(request, options)

    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_data(result["data"]["items"]))
    render :json =>results.to_json , callback: params[:callback]
  end

  def favor
    API::Product.favor(request, productid: params[:id])

    respond_to { |format| format.js }
  end

  def unfavor
    API::Product.unfavor(request, productid: params[:id])

    respond_to { |format| format.js }
  end

  def download_coupon
    API::Product.download_coupon(request, productid: params[:id])

    respond_to { |format| format.js }
  end

  def comment
    @comment = API::Comment.create(request, params.slice(:content, :replyuser).merge(sourceid: params[:id], sourcetype: 1))[:data]

    respond_to { |format| format.js }
  end

  protected

  def covert_options_for_search(type, entity_id)
    options = {}
    if type == 'category'
      options[:tagid]    = entity_id
    elsif type == 'brand'
      options[:brandid]  = entity_id
    elsif type == 'store'
      options[:storeid]  = entity_id
    elsif type == 'sortby' 
      options[:sortby] = entity_id
    elsif type == 'promotionid'
      options[:promotionid] = entity_id
    elsif type == 'topicid'
      options[:topicid] = entity_id
    end
    options
  end

  def gen_search_data(datas)
    results = {}
    items = []
    datas && datas.each do |item|
      image_info = item["resources"].first
      items << {
        title:     item["name"],
        price:     item["price"],
        originalPrice:  item["unitprice"],
        likeCount: item["likecount"],
        url:       front_product_path(item["id"]||item["productid"]),
        imageUrl:  image_info.blank? ? default_product_pic_url : middle_pic_url(image_info),       
        imageOriginWidth: image_info.blank? ?320 : image_info["width"],
        imageOriginHeight: image_info.blank? ?320 : image_info["height"],
        flag: item["promotionFlag"],
        is4sale: item["is4sale"]
      }
    end
    results[:datas] = items
    results
  end

  def gen_share(datas)
    results = {}
    items = []
    datas && datas.each do |item|
      image_info = item["resources"].first
      items << {
        title:     item["productname"],
        price:     item["price"],
        originalPrice:  item["unitprice"],
        likeCount: item["likecount"],
        url:       front_product_path(item["id"]||item["productid"]),
        imageUrl:  image_info.blank? ? default_product_pic_url : middle_pic_url(image_info)
      }
    end
    results[:datas] = items
    results
  end

  def gen_data(datas, type = nil)
    results = {}
    items = []
    datas && datas.each do |item|
      id = item["id"]||item["productid"]
      url = type == "2" ? front_promotion_path(id) : front_product_path(id)
      image_info = item["resources"].first if item["resources"].present?
      items << {
        title:     item["name"].blank? ? item["productname"] : item["name"],
        price:     item["price"],
        originalPrice:  item["unitprice"],
        likeCount: item["likecount"],
        url:       url, 
        imageUrl:  image_info.blank? ? default_product_pic_url : middle_pic_url(image_info),
        imageOriginWidth: image_info.blank? ?320 : image_info["width"],
        imageOriginHeight: image_info.blank? ?320 : image_info["height"],
        flag: item["promotionFlag"],
        is4sale: item["is4sale"]
      }
    end
    results[:datas] = items
    results
  end

end
