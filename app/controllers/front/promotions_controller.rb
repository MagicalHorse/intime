# encoding: utf-8
class Front::PromotionsController < Front::BaseController
  before_filter :authenticate!, only: [:favor, :unfavor, :download_coupon, :comment]

  def show
    @promotion = Stage::Promotion.fetch(params[:id])
    @store     = @promotion.store

    if signed_in?
      @promotion_info = API::Promotion.availoperation(request, promotionid: params[:id])['data']
    end
  end

  def index
    @banners = Stage::Banner.list
  end

  def get_list
    params[:storeid] = params[:entity_id]
    promotions = Stage::Promotion.list(params.slice(:page, :sort, :storeid).merge(pagesize: params[:pageSize]))

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
    @comment = API::Comment.create(request, params.slice(:content, :replyuser).merge(sourceid: params[:id], sourcetype: 2))[:data]

    respond_to { |format| format.js }
  end

  protected

  def handle_items(items)
    items.map! do |item|
      {
        title:        item.name,
        imageUrl:     item.image_urls.first,
        url:          front_promotion_path(item.id),
        startDate:    change_time_zone(item.startdate).strftime('%Y.%m.%d'),
        endDate:      change_time_zone(item.enddate).strftime('%Y.%m.%d'),
        description:  item.description,
        likeCount:    item.likecount,
        storeId:      item.store.try(:id),
        storeName:    item.store.try(:name),
        storeUrl:     front_store_path(item.store.try(:id))
      }
    end
  end
end
