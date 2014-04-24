# encoding: utf-8
class Front::ProfileController < Front::BaseController
  before_filter :authenticate!

  def index
    @card = API::Card.detail(request)[:data]
  end

  def edit
    @user = API::Customer.show(request)[:data].slice(:desc, :nickname, :logo, :gender, :mobile)
  end

  def update
    result = API::Customer.update(request, params[:user].except(:logo))

    if result[:isSuccessful]
      redirect_to front_my_profile_path, notice: '更新成功。'
    else
      @user = params[:user]
      flash.alert = result[:message]
      render :edit
    end
  end
end
