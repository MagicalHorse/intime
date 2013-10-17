# encoding: utf-8
class Front::ProductsController < Front::BaseController 


  def show
    @product = Stage::Product.fetch(params[:id])
  end

  def index
  end

  def search_api
    options = {
      page: params[:page],
      pagesize: 10,
      term: params[:term]
    }
    result  = Stage::Product.search(options)
    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_data(result["data"]["products"]))
    render :json =>results.to_json , callback: params[:callback]
  end

  def list_api
    options = {
      page: params[:page],
      pagesize: 10,
      sortby: params[:sortby] || 1
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
    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_data(result["data"]["items"]))
    render :json =>results.to_json , callback: params[:callback]
  end

  def my_share_list_api
    options = {
      page: params[:page],
      pagesize: 10,
      userid: 1
    }

    result = API::Product.my_share_list(request, options)

    results = result["data"].slice("pageindex", "pagesize", "totalcount", "totalpaged")
    results.merge! (gen_data(result["data"]["items"]))
    render :json =>results.to_json , callback: params[:callback]
  end

  
  protected

  def covert_options_for_search(type, entity_id)
    options = {}
    if type == 'category'
      options[:tagid]    = entity_id
    elsif type == 'brand'
      options[:brandid]  = entity_id
    elsif type == 'store'
      options[:storied]  = entity_id
    end
    options
  end

  def gen_share(datas)
    results = {}
    items = []
    datas && datas.each do |item|
      image_info = item["resources"].first
      items << {
        title:     item["productname"],
        price:     item["price"],
        originalPrice:  item["originprice"],
        likeCount: item["likecount"],
        url:       "",
        imageUrl:  image_info.blank? ? "" : middle_pic_url(image_info)
      }
    end
    results[:datas] = items
    results
  end

  def gen_data(datas)
    results = {}
    items = []
    datas && datas.each do |item|
      image_info = item["resources"].first
      items << {
        title:     item["name"],
        price:     item["price"],
        originalPrice:  item["price"],
        likeCount: item["favorable"],
        url:       "",
        imageUrl:  image_info.blank? ? "" : middle_pic_url(image_info)
      }
    end
    results[:datas] = items
    results
  end

end
