class Ims::Store::StoresController < Ims::Store::BaseController
  
  def index
  	 
  end

  def edit
  	
  end

  def update
  	 redirect_to ims_store_store_path(1) 
  end

  def show
  end

  def my
    @store = Ims::Store.my(request)
    binding.pry
  end

  
end