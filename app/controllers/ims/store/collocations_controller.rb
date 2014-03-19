class Ims::Store::CollocationsController < Ims::Store::BaseController

  def index

  end

  def new
    # @collocation = Ims::Collocation.find(params[:id]) || Ims::Collocation.create
    @collocation = Ims::Collocation.new
  end

  def create
    @collocation = Ims::Collocation.find(params[:id])
  	@collocation.update_attribtes(params[:collocation])
  end

  def show
    @collocation = Ims::Collocation.find(params[:id])
  end


end
