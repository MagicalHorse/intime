# encoding: utf-8
class Front::EnvironmentController < Front::BaseController

  # 省市区
  def supportshipments
    render json: format_items(API::Environment.supportshipments(request)[:data], :page, :pagesize, :totalcount, :totalpaged), callback: params[:callback]
  end
end
