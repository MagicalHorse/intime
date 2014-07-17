# encoding: utf-8

class Ims::CombosController < Ims::BaseController
  skip_after_filter :set_no_cache, :only=>[:index]
  layout "ims/store"

  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @private_to = params[:private_to]
    @store_id = params[:store_id]
    @title = "组合展示"
    @can_share = true if @remote_combo[:data][:is_online]
    @template_id = @remote_combo[:data][:template_id]
    session[:store_id] = @remote_combo[:data][:store_id]
    @share_url = @private_to.present? ? ims_combo_url(id: @remote_combo[:data][:id], t: Time.now.to_i, private_to: 'true') : ims_combo_url(id: @remote_combo[:data][:id], t: Time.now.to_i)
    @img_url = @remote_combo[:data][:images].present? ? @remote_combo[:data][:images].first['name'] : Settings.default_image_url.product.middle
  end

  def index
    @search = ::Combo.es_search(store_id: [params[:store_id], params[:default_store_id]].find{|store_id| store_id.present?}, keywords: params[:keywords], page: params[:page], per_page: params[:per_page])
    @combos = @search[:data]
    @stores = ::Store.es_search
    @store = ::Store.es_search(store_id: params[:store_id]).first if params[:store_id].present?
    @default_store = ::Store.es_search(store_id: params[:default_store_id]).first if params[:default_store_id].present?
    @can_share = true
    store_name = (store = [@default_store, @store].find{|store| store.present?}).present? ? store["name"] : "银泰百货"
    @share_title = store_name + "商品推荐"
    @share_desc = store_name + "有新商品上架了，赶快过来看看~"
    @share_img_url = Combo.img_url(@combos.first) if @combos.first.present?
    @title = @default_store.present? ? @default_store["name"] : (@store.present? ? @store["name"] : "商品组合列表")
    respond_to do |format|
      format.html{}
      format.json{render "list"}
    end
  end

  def upload
    image_data = params[:img].split(',')[1]
    image, file_name = upload_image(image_data)
    @combo = ::Combo.find(params[:id])
    @image = Ims::Combo.upload_img(request, {image: image, image_type: 15})

    if @image[:isSuccessful]
      image = ComboPic.create({remote_id: @image[:data][:id], url: @image[:data][:url], combo_id: @combo.id})
      File.delete("#{Rails.root}/public/#{file_name}")
      json = {"status" => 1, "img" => @image[:data][:url], "id" => image.id}.to_json
    else
      json = {"status" => 0, message: @image["message"]}.to_json
    end
    render :json => json
  end


  def ajax
    @combo = Ims::Combo.show(request, {:id => params[:combo_id]})[:data]
    @product = ::Product.get_by_id({id: params[:id]})[:data]
  end
end
