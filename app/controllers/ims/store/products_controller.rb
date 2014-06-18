# encoding: utf-8
class Ims::Store::ProductsController < Ims::Store::BaseController

  def index
    @combo = ::Combo.find(params[:combo_id]) if params[:combo_id].present?
    # @search = ::Product.es_search(per_page: params[:per_page], page: params[:page])
    # @products = @search[:data]
    @search = Ims::Product.list(request, page: params[:page], pagesize: params[:per_page] || 10)
    @products = @search["data"]["items"]
    @title = "已拍商品"
    respond_to do |format|
      format.html{}
      format.json{render "list"}
    end
  end

  def show
    @title = "商品详情"
    @product = Ims::Product.find(request, {id: params[:id]})[:data]
  end

  def new
    @title = "商品上传"
    @combo_id = params[:combo_id]
    @product = Ims::Product.find(request, {id: params[:product_id]})["data"] if params[:product_id].present?
    product_relation_data
  end

  def edit
    @title = "商品编辑"
    @product = Ims::Product.find(request, {id: params[:id]})["data"]
    product_relation_data
  end

  def create
    @combo = ::Combo.find_by_id(params[:combo_id])
    product = Ims::Product.create(request, {
      brand_id: params["brand_id"],
      sales_code: params["sales_code"],
      sku_code: params["sku_code"],
      price: params["price"],
      unitprice: params["unitprice"],
      category_id: params["category_id"],
      image_ids: params["image_ids"],
      sizes: params["sizes"],
      color_str: params["color_str"],
      desc: params["desc"],
      createcombo: params["createcombo"] == "1"
    })

    if product["isSuccessful"]
      if @combo.present?
        ComboProduct.create({:remote_id => product[:data][:id], :img_url => product[:data][:image], :product_type => "2",
         :price => product[:data][:price], :combo_id => @combo.try(:id),
         :brand_name => product[:data][:brand_name], :category_name => product[:data][:category_name]})
        redirect_to new_ims_store_combo_path(:combo_id => @combo.try(:id), t: Time.now.to_i)
      elsif (combo_id = product["data"].try(:[], :combo_id)).present?
        redirect_to ims_combo_path(combo_id, :private_to => true, :t => Time.now.to_i)
      else
        redirect_to ims_store_sells_path(tab: "products")
      end
    else
      $logger.error(product["message"])
      redirect_to new_ims_store_product_path(:combo_id => @combo.try(:id))
    end
  end

  def update
    product = Ims::Product.update(request, {
      id: params[:id],
      brand_id: params["brand_id"],
      sales_code: params["sales_code"],
      sku_code: params["sku_code"],
      unitprice: params["unitprice"],
      price: params["price"],
      category_id: params["category_id"],
      image_ids: params["image_ids"],
      sizes: params["sizes"],
      color_str: params["color_str"],
      desc: params["desc"],
      createcombo: params["createcombo"] == "1"
    })

    if product["isSuccessful"]
      if (redirect_url = params[:redirect_url]).present? && !redirect_url.include?("ims/store/sells")
        redirect_to redirect_url
      else
        redirect_to ims_store_sells_path(tab: "products")
      end
    else
      redirect_to edit_ims_store_product_path(params[:id])
    end
  end

  def tutorials
  end

  def add_to_combo
    @combo = ::Combo.find(params[:combo_id])

    product = params[:product_type] == "2" ? Ims::Product.find(request, {:id => params[:id]}) : ::Product.fetch_product(params[:id])

    combo_product = ComboProduct.create({:remote_id => product[:data][:id], :img_url => product[:data][:image],
      :product_type => params[:product_type], :price => product[:data][:price], :combo_id => @combo.id,
      :brand_name => product[:data][:brand_name], :category_name => product[:data][:category_name]})

    respond_to do |format|
      format.html{redirect_to new_ims_store_combo_path(:combo_id => @combo.id, t: Time.now.to_i)}
      format.json{render json: {status: combo_product.valid?, message: combo_product.errors.messages.values.flatten.join(", "), id: combo_product.try(:id)}.to_json}
    end

  end

  def search
    @title = "商品搜索"
    @combo = ::Combo.find(params[:combo_id]) if params[:combo_id].present?
    @search = ::Product.es_search(per_page: params[:per_page] || 12, page: params[:page], from_discount: params["from_discount"], to_discount: params["to_discount"], from_price: params["from_price"], to_price: params["to_price"], brand_id: params["brand_id"], keywords: params["keywords"])
    @products = @search[:data]
    # @products = @search[:data].group_by{|obj| obj["createdDate"].to_date}.values
    @brands = Brand.es_search
    respond_to do |format|
      format.html{}
      format.json{render "search_list"}
    end
  end

  def upload
    imagedata = params[:img].split(',')[1]

    FileUtils.mkdir("#{Rails.root}/public/uploads") if !File.exist?("#{Rails.root}/public/uploads")

    filename = 'uploads/'+ Time.now.to_i.to_s + '.jpg'
    File.open('public/'+filename, 'wb') do|f|
      f.write(Base64.decode64(imagedata))
    end

    img = File.new("#{Rails.root}/public/#{filename}", 'rb')
    @image = Ims::Combo.upload_img(request, {:image => img, :image_type => 1})

    if @image[:isSuccessful]
      File.delete("#{Rails.root}/public/#{filename}")
      json = {"status" => 1, "img_url" => @image[:data][:url], "id" => @image[:data][:id]}.to_json
    else
      json = {"status" => 0}.to_json
    end
    render :json => json
  end

  def add_size
    render "size.json.erb"
  end


  protected

  def product_relation_data
    @brands = Ims::Assistant.brands(request)["data"]["items"]
    # @categories = Ims::ProductCategory.list(request)["data"]["items"]
    @categories = Tag.es_search(per_page: 200000)[:data]
    @codings = Ims::ProductCoding.list(request)["data"]["items"]
  end

end
