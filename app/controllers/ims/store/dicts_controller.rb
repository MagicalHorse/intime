class Ims::Store::DictsController < Ims::Store::BaseController

  def product_sizes
    # @categories = Ims::ProductCategory.list(request)["data"]["items"]
    # @sizes = @categories.find{|obj| obj['id'].to_s == params["category_id"]}["sizes"]
    @sizes = Ims::ProductSize.list(request, category_id: params["category_id"])
    render json: @sizes.to_json
  end
end