class Ims::Store::DictsController < Ims::Store::BaseController

  def product_sizes
    categories = Tag.es_search(category_id: params["category_id"], per_page: 100000)[:data]
    @sizes = categories.first.try(:sizes)
    render json: @sizes.to_json
  end
end