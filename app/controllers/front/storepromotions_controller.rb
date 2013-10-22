class Front::StorepromotionsController < Front::BaseController

  def index
    @storepromotions = Stage::Storepromotion.list(params.slice(:page))
  end
end
