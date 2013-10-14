# encoding: utf-8
class Front::ProductsController < Front::BaseController 

  before_filter :check_current_user, :only => [:my_favorite, :my_share_list]

  def show
    pid = params[:id]
    prod = Product.search :per_page=>1,:page=>1 do 
            query do
              match :id,pid
            end
          end
    @product = prod.results[0]
    return render :text => t(:commonerror), :status => 404 if @product.nil?
  end

  def index
  end

  def my_favorite_api
    options = {
      page: params[:page],
      pagesize: 10,
      sourcetype: params[:loveType]
    }
    result = API::Product.my_favorite(request, options)
    render :json => gen_data(result).to_json, callback: params[:callback] 
  end

  def my_share_list_api
    options = {
      page: params[:page],
      pagesize: 10,
      userid: 1
    }
    result = API::Product.my_share_list(request, options)
    render json: gen_share(result).to_json, callback: params[:callback]
  end

  
  protected

  def check_current_user
    if  current_user.blank?
      redirect_to login_path
    end
  end

  def gen_share(result)
    items = []
    result["data"]["items"].each do |item|
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
    result = result["data"].slice(:pageindex, :pagesize, :totalcount, :totalpaged)
    result[:datas] = items
    result
  end

  def gen_data(result)
    items = []
    result["data"]["items"].each do |item|
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
    result = result["data"].slice(:pageindex, :pagesize, :totalcount, :totalpaged)
    result[:datas] = items
    result
  end

end
