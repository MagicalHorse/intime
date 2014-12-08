# encoding: utf-8

class Ims::Store::ProductsController < Ims::Store::BaseController

  before_filter :tags, only: [:new, :edit]
  before_filter :verify_can_modify_product, only: [:new, :edit, :create, :update]
  before_filter :setup_param_size, only: [:create, :update]
  before_filter :setup_title_and_is_system, only: :search

  def index
    @combo = ::Combo.find(params[:combo_id]) if params[:combo_id].present?
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

    product = Ims::Product.create(request, params[:product].merge({createcombo: params["createcombo"] == "1"}))

    if product["isSuccessful"]
      if @combo.present?
        ComboProduct.create({:remote_id => product[:data][:id], :img_url => product[:data][:image], :product_type => "2",
          :price => product[:data][:price], :combo_id => @combo.try(:id),
          :brand_name => product[:data][:brand_name], :category_name => product[:data][:category_name]})
        url = new_ims_store_combo_path(:combo_id => @combo.try(:id), t: Time.now.to_i)
      elsif (combo_id = product["data"].try(:[], :combo_id)).present?
        url = ims_combo_path(combo_id, :private_to => true, :t => Time.now.to_i)
      else
        url = ims_store_sells_path(tab: "products")
      end
      render json: {status: true, url: url}.to_json
    else
      $logger.error(product["message"])
      render json: {status: false, message: product["message"]}.to_json
    end
  end

  def update
    product = Ims::Product.update(request, params[:product].merge({createcombo: params["createcombo"] == "1"}))

    if product["isSuccessful"]
      if (redirect_url = params[:redirect_url]).present? && !redirect_url.include?("ims/store/sells")
        url = redirect_url
      elsif (combo_id = product["data"].try(:[], :combo_id)).present?
        url = ims_combo_path(combo_id, private_to: true, t: Time.now.to_i)
      else
        url = ims_store_sells_path(tab: "products")
      end
      render json: {status: true, url: url}.to_json
    else
      render json: {status: false, message: product["message"]}.to_json
    end
  end


  def add_to_combo
    @combo = ::Combo.find(params[:combo_id])
    # product = params[:product_type] == "2" ? Ims::Product.find(request, {:id => params[:id]}) : ::Product.fetch_product(params[:id])
    product = ::Product.fetch_product(params[:id])
    combo_product = ComboProduct.create({:remote_id => product[:data][:id], :img_url => product[:data][:image],
      :product_type => params[:product_type], :price => product[:data][:price], :combo_id => @combo.id,
      :brand_name => product[:data][:brand_name], :category_name => product[:data][:category_name]})

    respond_to do |format|
      format.html{redirect_to new_ims_store_combo_path(:combo_id => @combo.id, t: Time.now.to_i)}
      format.json{render json: {status: combo_product.valid?, message: combo_product.errors.full_messages.join(", "), id: combo_product.try(:id)}.to_json}
    end

  end

  def search
    @combo = ::Combo.find(params[:combo_id]) if params[:combo_id].present?
    # 如果是搜索其他专柜商品，那么只能是本门店的
    @search = ::Product.es_search(per_page: params[:per_page] || 8, page: params[:page], from_discount: params["from_discount"], to_discount: params["to_discount"], from_price: params["from_price"], to_price: params["to_price"], brand_id: params["brand_id"], keywords: params["keywords"], is_system: @is_system, store_id: Rails.env.development? ? nil : (@is_system == "0"  ? current_user.store_id : nil), gte: !Rails.env.development? && @is_system == "0" ? 7 : nil)
    @products = @search[:data]
    @brands = Brand.es_search
    respond_to do |format|
      format.html{}
      format.json{render "search_list"}
    end
  end

  def upload
    image_data = params[:img].split(',')[1]
    image, file_name = upload_image(image_data)
    @image = Ims::Combo.upload_img(request, {:image => image, :image_type => 1})

    if @image[:isSuccessful]
      File.delete("#{Rails.root}/public/#{file_name}")
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

  def setup_title_and_is_system
    @title = params[:is_system] == '1' ? "商品搜索" : '专柜商品搜索'
    @is_system = params[:is_system]
  end

  def product_relation_data
    @brands = Ims::Assistant.brands(request)["data"]["items"]
    @categories = Tag.es_search(per_page: 200000)[:data]
    @codings = Ims::ProductCoding.list(request)["data"]["items"]
  end

  def tags
    @tags = Tag.es_imstags_search[:data]
  end

  def verify_can_modify_product
    if !current_user.shopping_guide_operate?
      redirect_to ims_store_root_path
    end
  end

  def setup_param_size
    sizes = params[:product][:sizes]
    n = []
    sizes[:id].each_with_index do |size, index|
      n << {id: sizes[:id][index], name: sizes[:name][index], inventory: sizes[:inventory][index]}
    end
    params[:product][:sizes] = n

  end

end
