class Front::CommentsController < Front::BaseController
  before_filter :authenticate!, only: [:create]

  def index
  end

  def get_list
    if params[:sourceid].to_i == 0
      render_items({})
    else
      comments = API::Comment.index(request, params.slice(:sourceid, :sourcetype, :page, :pagesize))

      render_items((comments['data'].present? ? handle_items(comments['data']) : {}), 'comments')
    end
  end

  def create
    @comment = API::Comment.create(request, params[:comment].merge(replyuser: current_user.id))

    respond_to do |format|
      format.js
    end
  end

  def my_comments
    @comments = API::Comment.my_comments(request)
  end

  protected
  def handle_items(items)
    items['items'] = items['comments'].inject([]) do |_result, _comment|
      _result << {
        commentId: _comment['commentid'],
        content:  _comment['content'],
        createTime: _comment['createddate'],
        floor: 1,
        customer: {
          id: _comment['customer']['id'],
          nick_name: _comment['customer']['nick_name'],
          logo: _comment['customer']['logo'],
          url: ''
        }
      }

      _result
    end

    items
  end
end
