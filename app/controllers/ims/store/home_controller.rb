class Ims::Store::HomeController < Ims::Store::BaseController
  skip_filter :authenticate

  def index
  end

  def login
    @invite_code = params[:invite_code]   
    status = Ims::Store.create(request, {:invite_code => params[:invite_code]})
    if status[:isSuccessful]
      current_user.level = 3
      redirect_to my_ims_store_stores_path
    else
      @error = true
      render :action => :index
    end
  end

  def check_code
    
  end

end
