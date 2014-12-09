# encoding: utf-8
class Ims::Store::HomeController < Ims::Store::BaseController
  skip_filter :authenticate
  before_filter :go_store


  def index
  end

  def login
    @invite_code = params[:invite_code]
    @status = Ims::Store.create(request, {:invite_code => params[:invite_code]})
    logger.info("status: #{@status}")
    if @status[:isSuccessful]
      user = Ims::User.new({
        :id => @status[:data][:id],
        :email => @status[:data][:email],
        :level => @status[:data][:level],
        :nickname => @status[:data][:nickname],
        :mobile => @status[:data][:mobile],
        :isbindcard => @status[:data][:isbindcard],
        :logo => @status[:data][:logo],
        :operate_right => @status[:data][:operate_right],
        :token => @status[:data][:token],
        :store_id => @status[:data][:store_id],
        :associate_id => @status[:data][:associate_id],
        :max_comboitems => @status[:data][:max_comboitems]
      })
      session[:current_wx_user] = user
      redirect_to my_ims_store_store_path(id: user.associate_id, t: Time.now.to_i)
    elsif @status[:statusCode].to_i == 401
      session[:user_token] = nil
      cookies[:user_token] = nil
      redirect_to check_ims_store_stores_path
    else
      if @status["message"] == "邀请码已绑定！"
        session[:user_token] = nil
        cookies[:user_token] = nil
      end
      @error = true
      render :action => :index
    end
  end

  def check_code

  end


  private

  def go_store
    if current_user.associate_id.present?
      if params[:itpm].present?
        redirect_to my_ims_store_store_path(id: current_user.associate_id, t: Time.now.to_i, itpm: params[:itpm], group_id: session[:group_id])
      else
        redirect_to my_ims_store_store_path(id: current_user.associate_id, t: Time.now.to_i, group_id: session[:group_id])
      end
    end
  end

end
