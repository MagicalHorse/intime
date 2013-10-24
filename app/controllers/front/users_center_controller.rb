class Front::UsersCenterController < Front::BaseController 

  before_filter :authenticate!, :except => [:his_info, :his_favorite]

  #def his_favorite
    #@user_id = params[:userid]
  #end

  def his_promotion
    @user_id = params[:userid]
    options = {userid: params[:userid]}
    result  = API::Customer.his_show(request, options)
    @info   = gen_profile(result)
  end

  def his_share
    @user_id = params[:userid]
    options = {userid: params[:userid]}
    result  = API::Customer.his_show(request, options)
    @info   = gen_profile(result)
  end

  def profile
    result = API::Customer.show(request)
    @info = gen_profile(result)
  end

  def his_info
    @user_id = params[:userid]
    options = {userid: params[:userid]}
    result  = API::Customer.his_show(request, options)
    @info   = gen_profile(result)
  end

  #todo
  def follows
    options = { type: 0, userId: current_user.id }
    result = API::Follow.follows(request,options)
    @results = gen_data(result) if result["data"]["likes"].present?
  end

  #todo
  def fans
    options  = { type: 1, userId: current_user.id }
    result   = API::Follow.follows(request,options)
    @results = gen_data(result) if result["data"]["likes"].present?
    render :follows
  end

  def follow
    options  = { likeduserid: params[:user_id] }
    result   = API::Follow.follow(request,options)
    respond_to { |format| format.js }
  end

  def unfollow
    options  = { likeduserid: params[:user_id] }
    result   = API::Follow.unfollow(request,options)
    respond_to { |format| format.js }
  end

  protected

  def gen_profile(result)
    info = {}
    if result["data"].present?
      info[:id]     = result["data"]["id"]
      info[:name]   = result["data"]["nickname"]
      info[:logo]   = result["data"]["logo"] || href_of_user_logo
      info[:gender] = result["data"]["gender"]
      info[:desc]   = result["data"]["desc"]
      info[:mobile] = result["data"]["mobile"]
      info[:follows] = result["data"]["liketotal"] || 0
      info[:fans] =    result["data"]["likedtotal"] || 0
    end
    info
  end

  def gen_data(result)
    items = []
    result["data"]["likes"].each do |item|
      items << {
        id:         item["id"],
        level:      item["level"],
        logo:       item["logo"] || href_of_user_logo,
        nickname:   item["nickname"],
        liketotal:  item["liketotal"], 
        likedtotal: item["likedtotal"]
      }
    result[:datas] = items
    result
    end
  end

end
