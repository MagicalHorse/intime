class Ims::Store::CollocationsController < Ims::Store::BaseController

  #新建搭配
  def new
    # @collocation = Ims::Collocation.find(params[:id]) || Ims::Collocation.create
    # @collocation = Ims::Collocation.new
  end

  def create
    # @collocation = Ims::Collocation.find(params[:id])
  	# @collocation.update_attribtes(params[:collocation])
    redirect_to "/ims/store/collocations/1"
  end

  #查看搭配
  def show
    # @collocation = Ims::Collocation.find(params[:id])
  end

  def tutorials
  end

  def edit
  end

  def update
    redirect_to :action => :show    
  end


end
