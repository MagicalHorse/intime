class Ims::Store::CollocationsController < Ims::Store::BaseController

  def index

  end

  def new
    @collocation = Collocation.create
  end

  def create
  	 @collocation.update_attribtes(params[:collocation])
  end


end
