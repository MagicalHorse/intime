# encoding: utf-8
class Mini::Store::SalesCodesController < Mini::Store::BaseController
  def create
    sales_code = Mini::ProductCoding.create(request, {sale_code: params["coding"]})
    sales_codes = Mini::ProductCoding.list(request)["data"]["items"]
    # render json: {status: sales_code["isSuccessful"], data: sales_codes}
    render json: {status: true, data: sales_codes}
  end
end