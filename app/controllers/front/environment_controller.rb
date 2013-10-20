class Front::EnvironmentController < Front::BaseController

  # 省市区
  def supportshipments
    render json: format_items(API::Environment.supportshipments(request)[:data], :page, :pagesize, :totalcount, :totalpaged)
  end

  # 退货理由分类列表
  def supportrmareasons
    render json: format_items(API::Environment.supportrmareasons(request)[:data], :page, :pagesize, :totalcount, :totalpaged)
  end
end
