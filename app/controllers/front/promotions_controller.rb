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
  end
end
