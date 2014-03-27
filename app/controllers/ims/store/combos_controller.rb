class Ims::Store::CombosController < Ims::Store::BaseController

  #新建搭配
  def new
    if params[:combo_id].present?
      @combo = ::Combo.find(params[:combo_id])
    else
      @combo = ::Combo.create
    end
  end

  def create
    @combo = ::Combo.find(params[:id])
    Ims::Combo.create(request, @combo)
    redirect_to "/ims/store/combos/1"
  end

  #查看搭配
  def show
    
  end

  def tutorials
  end

  def edit
    # combo = Ims::Combo.show(params[:id])
    # @combo = Combo.find(params[:combo_id]) ||= Combo.create()
  end

  def update
    redirect_to :action => :show    
  end


end
