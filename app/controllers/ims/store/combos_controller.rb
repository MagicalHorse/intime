class Ims::Store::CombosController < Ims::Store::BaseController

  #新建搭配
  def new
    
  end

  def create
    
    redirect_to "/ims/store/combos/1"
  end

  #查看搭配
  def show
    
  end

  def tutorials
  end

  def edit
  end

  def update
    redirect_to :action => :show    
  end


end
