# encoding: utf-8
class Front::ExordersController < Front::BaseController 
  def show
    @product_name = params[:productname]
    @quantity = params[:quantity]
    @expdate = params[:expdate] || ''
    @remark = params[:remark] || ''
  end

end
