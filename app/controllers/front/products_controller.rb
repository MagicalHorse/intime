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
end
