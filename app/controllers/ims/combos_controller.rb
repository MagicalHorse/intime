# encoding: utf-8
class Ims::CombosController < Ims::BaseController
  layout "store"

  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @private_to = params[:private_to]
    @store_id = params[:store_id]
    @title = "组合展示"
    @can_share = true if @remote_combo[:data][:is_online]
    @template_id = @remote_combo[:data][:template_id]
    session[:store_id] = @remote_combo[:data][:store_id]
  end

  def index
    @title = "商品组合列表"
    options = {}
    store_id = params[:default_store_id] || params[:store_id]
    options[:brand_id] = params[:brand_id] if params[:brand_id].present?
    options[:store_id] = store_id if store_id.present?
    @combos = ::Combo.es_search(options)
    @store = ::Store.es_search(store_id: params[:default_store_id]).first if params[:default_store_id].present?
    @stores, @stores_ordered = ::Store.es_search, {}
    @brands, @brands_ordered = ::Brand.es_search, {}
    ('a'..'z').each do |char|
      @stores_ordered[char], @brands_ordered[char] = [], []
      @stores.each{ |s| @stores_ordered[char] << s if Pinyin.t(s.name)[0] == char }
      @brands.each{ |s| @brands_ordered[char] << s if Pinyin.t(s.name)[0] == char }
    end
  end

  def upload
  	imagedata = params[:img].split(',')[1]
    @combo = ::Combo.find(params[:id])

    FileUtils.mkdir("#{Rails.root}/public/uploads") if !File.exist?("#{Rails.root}/public/uploads")

    filename = 'uploads/'+ Time.now.to_i.to_s + '.jpg'
    File.open('public/'+filename, 'wb') do|f|
      f.write(Base64.decode64(imagedata))
    end

    img = File.new("#{Rails.root}/public/#{filename}", 'rb')
    @image = Ims::Combo.upload_img(request, {:image => img, :image_type => 15})

    if @image[:isSuccessful]
      image = ComboPic.create({remote_id: @image[:data][:id], url: @image[:data][:url], :combo_id => @combo.id})
      File.delete("#{Rails.root}/public/#{filename}")
      json = {"status" => 1, "img" => @image[:data][:url], "id" => image.id}.to_json
    else
      json = {"status" => 0}.to_json
    end
    render :json => json
  end


  def ajax
    @combo = Ims::Combo.show(request, {:id => params[:combo_id]})[:data]
    # @product = API::Order.new(request, productid: params[:id])[:data]
    @product = ::Product.get_by_id({id: params[:id]})[:data]
  end
end
