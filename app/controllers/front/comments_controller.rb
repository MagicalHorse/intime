# encoding: utf-8
class Front::ProfileController < Front::BaseController
  before_filter :authenticate! 

  def index
  end

  def create
    @comment = API::Comment.create(request, params[:comment].merge(replyuser: current_user.id))

    respond_to do |format|
      format.js
    end
  end
end
