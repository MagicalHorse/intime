# encoding: utf-8
class Front::AboutController < Front::BaseController

  def index
  end

  def feedback
  end

  def create_feedback
    @result = API::Feedback.create(request, params.slice(:content, :cantact))

    respond_to { |format| format.js }
  end

end
