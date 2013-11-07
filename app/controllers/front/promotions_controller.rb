class Front::PromotionsController < Front::BaseController 
  before_filter :authenticate!, only: [:favor, :unfavor, :download_coupon, :comment]

  def show
    @promotion = Stage::Promotion.fetch(params[:id])
    @store     = @promotion.store
    #@comments  = API::Comment.index(request, page: 1, pagesize: 1, sourcetype: 2, sourceid: @promotion.id)[:data]
    #@promotion_info = Stage::Promotion.availoperation(params[:id], token: request.session[:user_token])
  end

  def index
    @banners = Stage::Banner.list
  end

  def get_list
    promotions = Stage::Promotion.list(params.slice(:page, :sort).merge(pagesize: params[:pageSize]))

    render_datas(handle_items(promotions))
  end

  def favor
    API::Promotion.favor(request, promotionid: params[:id])

    respond_to { |format| format.js }
  end

  def unfavor
    API::Promotion.unfavor(request, promotionid: params[:id])

    respond_to { |format| format.js }
  end

  def download_coupon
    API::Promotion.download_coupon(request, promotionid: params[:id])

    respond_to { |format| format.js }
  end

  def comment
    @comment = API::Comment.create(request, params.slice(:content, :replyuser).merge(sourceid: params[:id], sourcetype: 2))

    respond_to { |format| format.js }
  end

  protected
  def handle_items(items)
    items.map! do |item|
      {
        title:        item.name,
        imageUrl:     item.image_urls.first,
        url:          front_promotion_path(item.id),
        startDate:    item.startdate.to_date.strftime('%Y.%m.%d'),
        endDate:      item.enddate.to_date.strftime('%Y.%m.%d'),
        description:  item.description,
        likeCount:    item.likecount,
        storeId:      item.store.try(:id),
        storeName:    item.store.try(:name),
        storeUrl:     front_store_path(item.store.try(:id))
      }
    end
  end
end
