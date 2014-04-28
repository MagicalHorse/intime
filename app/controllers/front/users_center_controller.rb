# encoding: utf-8
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
    @info  = gen_profile(API::Customer.his_show(request, options))
    render :profile
  end

  def his_info
    @user_id = params[:userid]
    options = {userid: params[:userid]}
    result  = API::Customer.his_show(request, options)
    @info   = gen_profile(result)
  end

  def follows
     options = {
      page: params[:page],
      pagesize: 10,
      type: 0,
      userid: params[:userid].present? ? params[:userid] : current_user.id
    }
    result = API::Follow.follows(request,options)

    if result["data"]["likes"].present?
      @results = gen_data(result)

      @results = Kaminari.paginate_array(
        @results,
        total_count: result["data"]["totalcount"].to_i
      ).page(result["data"]["pageindex"]).per(result["data"]["pagesize"])
    end

  end

  def fans
     options = {
      page: params[:page],
      pagesize: 10,
      type: 1,
      userid: params[:userid].present? ? params[:userid] : current_user.id
    }
    result   = API::Follow.follows(request,options)
    if result["data"]["likes"].present?
      @results = gen_data(result)

      @results = Kaminari.paginate_array(
        @results,
        total_count: result["data"]["totalcount"].to_i
      ).page(result["data"]["pageindex"]).per(result["data"]["pagesize"])
    end

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
      info[:logo]   = href_of_avatar_url(result["data"]["logo"])
      info[:gender] = result["data"]["gender"]
      info[:desc]   = result["data"]["desc"]
      info[:mobile] = result["data"]["mobile"]
      info[:follows] = result["data"]["liketotal"].to_i
      info[:fans] =    result["data"]["likedtotal"].to_i
      info[:isliked] = result["data"]["isliked"]
    end
    info
  end

  def gen_data(result)
    items = []
    result["data"]["likes"].each do |item|
      items << {
        id:         item["id"],
        level:      item["level"],
        logo:       href_of_avatar_url(item["logo"]),
        nickname:   item["nickname"],
        liketotal:  item["liketotal"].to_i,
        likedtotal: item["likedtotal"].to_i,
        sharetotal: item["sharetotal"].to_i
      }
    result[:datas] = items
    end
    result[:datas]
  end

end
