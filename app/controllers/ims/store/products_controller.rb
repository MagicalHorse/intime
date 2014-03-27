class Ims::Store::ProductsController < Ims::Store::BaseController

  def index
    @combo = ::Combo.find(params[:combo_id]) if params[:combo_id]
    @products = Ims::Product.list(request)["data"]["items"]
  end

  def show

  end

  def new
    @combo_id = params[:combo_id]
    product_relation_data
  end

  def edit
    product_relation_data
  end

  def create
    @combo = ::Combo.find(params[:combo_id])
    product = Ims::Product.create(request, {
      image: params["image"],
      brand_id: params["brand_id"],
      sales_code: params["coding_id"],
      sku_code: params["item"],
      price: params["weixin_price"],
      category_id: params["category_id"],
      size_str: params["size_str"],
      size_ids: params["size_ids"]
    })
    if product["isSuccessful"]
      @combo.combo_products.create({:remote_id => product[:data][:id], :img_url => product[:data][:image], :product_type => "2", :price => product[:data][:price] })
      redirect_to new_ims_store_combo_path(:combo_id => @combo.id)
    else
      redirect_to new_ims_store_product_path
    end
  end

  def tutorials
  end

  def add_to_combo
    @combo_id = params[:combo_id]
    product = Ims::Product.show(request, {:id => params[:id]})
    @combo.combo_products.create({:remote_id => product[:data][:id], :img_url => product[:data][:image], :product_type => "2", :price => product[:data][:price] })
    redirect_to new_ims_store_combo_path(:combo_id => @combo.id)
  end


  protected

  def product_relation_data
    @brands = Ims::ProductBrand.list(request)["data"]["items"]
    @categories = Ims::ProductCategory.list(request)["data"]["items"]
    @codings = Ims::ProductCoding.list(request)["data"]["items"]
    # @sizes = @categories.first["sizes"]
  end

end