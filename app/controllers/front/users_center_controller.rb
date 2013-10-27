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

  def his_profile
    options = {userid: params[:userid]}
    @info  = API::Customer.his_show(request, options)
    render :profile
  end

  def his_info
    @user_id = params[:userid]
    options = {userid: params[:userid]}
    result  = API::Customer.his_show(request, options)
    @info   = gen_profile(result)
  end

  def follows
    userid = params[:userid].present? ? params[:userid] : current_user.id
    options = { type: 0, userid: userid }
    result = API::Follow.follows(request,options)
    @results = gen_data(result) if result["data"]["likes"].present?
  end

  def fans
    userid = params[:userid].present? ? params[:userid] : current_user.id
    options  = { type: 1, userId: params[:userid] || userid }
    result   = API::Follow.follows(request,options)
    @results = gen_data(result) if result["data"]["likes"].present?
  end

  def follow
    options  = { likeduserid: params[:id] }
    @result   = API::Follow.follow(request,options)
    respond_to { |format| format.js }
  end

  def unfollow
    options  = { likeduserid: params[:id] }
    @result   = API::Follow.unfollow(request,options)
    respond_to { |format| format.js }
  end

  protected

  def gen_profile(result)
    info = {}
    if result["data"].present?
      info[:id]     = result["data"]["id"]
      info[:name]   = result["data"]["nickname"]
      info[:logo]   = href_of_avatar_url(gen_user_logo(result["data"]["logo"]))
      info[:gender] = result["data"]["gender"]
      info[:desc]   = result["data"]["desc"]
      info[:mobile] = result["data"]["mobile"]
      info[:follows] = result["data"]["liketotal"].present? ? result["data"]["liketotal"] : 0
      info[:fans] =    result["data"]["likedtotal"].present? ? result["data"]["likedtotal"] : 0
    end
    info
  end

  def gen_data(result)
    items = []
    result["data"]["likes"].each do |item|
      items << {
        id:         item["id"],
        level:      item["level"],
        logo:       href_of_avatar_url(gen_user_logo(item["logo"])),
        nickname:   item["nickname"],
        liketotal:  item["liketotal"].present? ? item["liketotal"] : 0,
        likedtotal: item["likedtotal"].present? ? item["likedtotal"]  : 0
      }
    result[:datas] = items
    end
    result[:datas]
  end

  def gen_user_logo(logo)
    logo.to_s + '_100x100.jpg' if logo.present?
  end

end
