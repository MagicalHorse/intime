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
    @product = Ims::Product.find(request, {id: params[:id]})
    @product = {id: 1, image: "/images/1.jpg", price: 100.1, brand_id: 2, brand_name: "mockup品牌1",
      sales_code: "mockupsalescode1", sku_code: "sku_code", category_id: 1,
      category_name: "mockup分类1", size_str: '1111', size: [{size_id: 1, size_name: "mockup尺码1"}, {size_id: 2, size_name: "mockup尺码2"}]}
    @sizes = Ims::ProductSize.list(request, {category_id: @product[:category_id].to_i})
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
      ComboProduct.create({:remote_id => product[:data][:id], :img_url => product[:data][:image], :product_type => "2", :price => product[:data][:price], :combo_id => @combo.id})
      redirect_to new_ims_store_combo_path(:combo_id => @combo.id)
    else
      redirect_to new_ims_store_product_path
    end
  end

  def update
    product = Ims::Product.update(request, {
      id: params[:id],
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
      redirect_to ims_store_products_path
    else
      redirect_to edit_ims_store_product_path(params[:id])
    end
  end

  def tutorials
  end

  def add_to_combo
    @combo_id = params[:combo_id]
    product = Ims::Product.find(request, {:id => params[:id]})
    ComboProduct.create({:remote_id => product[:data][:id], :img_url => product[:data][:image], :product_type => "2", :price => product[:data][:price], :combo_id => @combo.id})
    redirect_to new_ims_store_combo_path(:combo_id => @combo.id)
  end

  def search
    @combo = ::Combo.find(params[:combo_id]) if params[:combo_id]
    @searches = Ims::Product.search(request, type: params["type"], from: params["form"], to: params["to"], id: params["brand_id"], keywords: params["keywords"])["data"]["items"]
    @products = @searches.group_by{|obj| obj["create_date"].to_date}.values
    @brands = Ims::ProductBrand.list(request)["data"]["items"]
  end


  protected

  def product_relation_data
    @brands = Ims::ProductBrand.list(request)["data"]["items"]
    @categories = Ims::ProductCategory.list(request)["data"]["items"]
    @codings = Ims::ProductCoding.list(request)["data"]["items"]
    # @sizes = @categories.first["sizes"]
  end

end