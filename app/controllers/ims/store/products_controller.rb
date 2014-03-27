class Ims::Store::ProductsController < Ims::Store::BaseController

  def index

  end

  def show

  end

  def new
    product_relation_data
  end

  def create
    product = Ims::Product.create(request, {
      brand_id: params["brand_id"],
      sales_code: params["coding_id"],
      sku_code: params["item"],
      price: params["weixin_price"],
      category_id: params["category_id"],
      size_str: params["size_str"],
      size_ids: params["size_ids"]
    })
    if product["isSuccessful"]
      redirect_to ims_store_products_path
    else
      redirect_to new_ims_store_product_path
    end
  end

  def tutorials
  end


  protected

  def product_relation_data
    @brands = Ims::ProductBrand.list(request)["data"]["items"]
    @categories = Ims::ProductCategory.list(request)["data"]["items"]
    @codings = Ims::ProductCoding.list(request)["data"]["items"]
    # @sizes = @categories.first["sizes"]
  end

end