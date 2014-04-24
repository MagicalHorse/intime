# encoding: utf-8
class Ims::Store::DictsController < Ims::Store::BaseController

  def product_sizes
    categories = Tag.es_search(category_id: params["category_id"], per_page: 100000)[:data]
    category = categories.first
    @sizes = category.try(:sizes)
    render json: {size_type: category["sizeType"], data: @sizes}.to_json
  end
end
