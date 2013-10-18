class Front::CommentsController < Front::BaseController
  before_filter :authenticate!, only: [:create]

  def index
  end

  def get_list
    comments = API::Comment.index(request, params.slice(:sourceid, :sourcetype))
  end

  def create
    @comment = API::Comment.create(request, params[:comment].merge(replyuser: current_user.id))

    respond_to do |format|
      format.js
    end
  end
end
