class Front::UsersCenterController < Front::BaseController 

  before_filter :authenticate!

  def follows
    options = { type: 0, userId: current_user.id }
    result = API::Follow.follows(request,options)
    @results = gen_data(result) if result["data"]["likes"].present?
  end

  def fans
    options  = { type: 1, userId: current_user.id }
    result   = API::Follow.follows(request,options)
    @results = gen_data(result) if result["data"]["likes"].present?
    render :follows
  end

  def follow
    options  = { likeduserid: params[:user_id] }
    result   = API::Follow.follow(request,options)
  end

  protected

  def gen_data(result)
    items = []
    result["data"]["likes"].each do |item|
      items << {
        id:         item["id"],
        level:      item["level"],
        logo:       item["logo"],
        nickname:   item["nickname"],
        liketotal:  item["liketotal"], 
        likedtotal: item["likedtotal"]
      }
    result[:datas] = items
    result
    end
  end

end
