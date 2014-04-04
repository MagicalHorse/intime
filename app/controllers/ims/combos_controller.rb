class Ims::CombosController < Ims::BaseController
  layout "store"
  
  def show
    @combo = Ims::Combo.show(request, id: params[:id])
  end
end