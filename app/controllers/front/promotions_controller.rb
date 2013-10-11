class Front::PromotionsController < Front::BaseController 
  before_filter :update_user, only: [:index], if: :signed_in?

  def show
    pid = params[:id]
    pro = Promotion.search :per_page=>1,:page=>1 do 
            query do
              match :id,pid
            end
          end
    @promotion = pro.results[0]
    return render :text => t(:commonerror), :status => 404 if @promotion.nil?
  end

  def index
    @banners = Stage::Banner.list
  end

  def get_list
    promotions = Stage::Promotion.list(page: params[:page], pagesize: params[:pageSize], sort: 1)

    render_items(handle_promotions(promotions))
  end

  protected
  def handle_promotions(items)
    items.map! do |item|
      {
        title:        item.name,
        imageUrl:     item.image_url,
        url:          '',
        startDate:    item.startdate,
        endDate:      item.enddate,
        description:  item.description,
        likeCount:    0,
        storeId:      item.store.try(:id),
        storeName:    item.store.try(:name),
        storeUrl:     ''
      }
    end
  end
end
