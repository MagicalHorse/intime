class Ims::Store::HomeController < Ims::Store::BaseController
  skip_filter :authenticate
  before_filter :go_store

  def index
  end

  def login
    @invite_code = params[:invite_code]
    status = Ims::Store.create(request, {:invite_code => params[:invite_code]})
    if status[:isSuccessful]
      current_user.level = status[:data][:level]
      current_user.store_id = status[:data][:assistant_id]
      current_user.operate_right = status[:data][:operate_right]
      redirect_to my_ims_store_store_path(:id => current_user.store_id)
    else
      @error = true
      render :action => :index
    end
  end

  def check_code

  end

  private
  def go_store
    if current_user.store_id.present?
      redirect_to my_ims_store_store_path(:id => current_user.store_id)
    end
  end

end
