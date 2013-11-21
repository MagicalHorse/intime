class Front::CommentsController < Front::BaseController
  before_filter :authenticate!, only: [:create]

  def index
  end

  def get_list
    if params[:sourceid].to_i == 0
      render_items({})
    else
      options = {page: 1, pagesize: 10}.merge(params.slice(:page, :pagesize, :sourceid, :sourcetype))

      comments = API::Comment.index(request, options)

      render_items((comments['data'].present? ? handle_items(comments['data']) : {}), 'comments')
    end
  end

  def create
    @comment = API::Comment.create(request, params[:comment].merge(replyuser: current_user.id, sourcetype: 3))[:data]

    respond_to { |format| format.js }
  end

  def my_comments
    options = {page: 1, pagesize: 10}.merge(params.slice(:page, :pagesize))
    @comments = API::Comment.my_comments(request, options)[:data]

    @comments = Kaminari.paginate_array(
      @comments[:items],
      total_count: @comments[:totalcount].to_i
    ).page(@comments[:pageindex]).per(@comments[:pagesize])
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
          nickname: _comment['customer']['nickname'],
          logo: href_of_avatar_url(_comment['customer']['logo']),
          url: front_his_info_path(_comment['customer']['id'])
        },
        comments: []
      }

      _result
    end

    items
  end
end
