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
    data   =  result["data"]["items"] if result["data"].present?
    render_items(mock_up)
  end

  def my_share_list
  end

  protected

  def mock_up

   (1..9).inject([]) do |_r, _i|
      _r << {
        title:          '开衫连帽卫衣 ASDF335 -2 黛紫色',
        imageUrl:       'http://yt.seekray.net/0909/temp/440_350_1.jpg',
        url:            'http://www.baidu.com',
        price:          11,
        originalPrice:  22,
        likeCount:      900,
      }

      _r
    end
  end
end
