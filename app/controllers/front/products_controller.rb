# encoding: utf-8
class Front::ProductsController < Front::BaseController 

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

  def my_favorite
    options = {
      page: params[:page],
      pagesize: 10,
      sourcetype: params[:sourcetype] || 1
    }
    result = API::Product.my_favorite(request, options)
    render :json => gen_data(result)
  end

  def my_share_list
    options = {
      page: params[:page],
      pagesize: 10,
      userid: 1
    }
    result = API::Product.my_share_list(request, options)
    render :json => result.to_json
  end

  protected

  def gen_data(result)
    items = []
    result["data"]["items"].each do |item|
      image_info = item["resources"].first
      items << {
        title:     item["name"],
        price:     item["price"],
        oriprice:  item["price"],
        likecount: item["favorable"],
        url:       "",
        image:     image_info.blank? ? "" : ApplicationController.helpers.middle_pic_url(image_info)
      }
    end
    result = result["data"].slice(:pageindex, :pagesize, :totalcount, :totalpaged)
    result[:data] = items
    result
  end

end
