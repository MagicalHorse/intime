class Front::StorepromotionsController < Front::BaseController

  def index
    @storepromotions = Stage::Storepromotion.list(params.slice(:page))
  end

  def show
    @storepromotion = Stage::Storepromotion.fetch(params[:id])
  end

  def exchange
    
  end
end
