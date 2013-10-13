class Front::PromotionsController < Front::BaseController 

  def show
    @promotion = Stage::Promotion.fetch(params[:id])
    @store     = @promotion.store
  end

  def index
    @banners = Stage::Banner.list
  end

  def get_list
    promotions = Stage::Promotion.list(page: params[:page], pagesize: params[:pageSize], sort: 1)

    render_datas(handle_items(promotions))
  end

  protected
  def handle_items(items)
    items.map! do |item|
      {
        title:        item.name,
        imageUrl:     item.image_urls.first,
        url:          promotion_path(item.id),
        startDate:    item.startdate.to_date.strftime('%Y.%m.%d'),
        endDate:      item.enddate.to_date.strftime('%Y.%m.%d'),
        description:  item.description,
        likeCount:    item.likecount,
        storeId:      item.store.try(:id),
        storeName:    item.store.try(:name),
        storeUrl:     ''
      }
    end
  end
end
