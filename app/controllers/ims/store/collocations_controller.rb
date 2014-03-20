class Ims::Store::CollocationsController < Ims::Store::BaseController

  #新建搭配
  def new
    # @collocation = Ims::Collocation.find(params[:id]) || Ims::Collocation.create
    @collocation = Ims::Collocation.new
  end

  def create
    @collocation = Ims::Collocation.find(params[:id])
  	@collocation.update_attribtes(params[:collocation])
  end

  #查看搭配
  def show
    # @collocation = Ims::Collocation.find(params[:id])
  end

  def tutorials
  end


end
