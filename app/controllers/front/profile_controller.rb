# encoding: utf-8
class Front::ProfileController < Front::BaseController
  before_filter :authenticate!

  def index
  end
end
