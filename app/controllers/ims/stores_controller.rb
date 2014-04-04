class Ims::StoresController < Ims::BaseController
  layout "store"
  
  def show
    @store = Ims::Store.show(request, id: params[:id])
  end
end