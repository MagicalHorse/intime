# encoding: utf-8

class Ims::Store::SalesCodesController < Ims::Store::BaseController
  def create
    sales_code = Ims::ProductCoding.create(request, {sale_code: params["coding"]})
    sales_codes = Ims::ProductCoding.list(request)["data"]["items"]
    render json: {status: sales_code["isSuccessful"], data: sales_codes, message: sales_code["message"]}
  end
end
