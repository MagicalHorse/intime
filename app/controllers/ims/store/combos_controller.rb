class Ims::Store::CombosController < Ims::Store::BaseController

  #新建搭配
  def new
    @combo = ::Combo.find_by_id(params[:combo_id]) || @combo = ::Combo.create
    @online_num = Ims::Combo.online_num(request)[:data][:total_count] rescue 0
  end

  def create
  end

  #查看搭配
  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
  end

  def tutorials
  end
 
  def update_desc
    @combo = ::Combo.find(params[:id])
    @combo.update_attributes({:desc => params[:desc], :private_to => params[:private_to]})

    render :json => {:status => "ok"}.to_json
  end

  #预览
  def preview
    @combo = ::Combo.find(params[:id])
  end

  def edit
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @remote_id = @remote_combo[:data][:id]

    if params[:combo_id].present?
      @combo = ::Combo.find(params[:combo_id])
    else
      @combo = ::Combo.create({:desc => @remote_combo[:data][:desc], :private_to => @remote_combo[:data][:private_to],
       :combo_type => @remote_combo[:data][:combo_type]})

      @remote_combo[:data][:products].each do |product|
        if product[:product_type].blank? || product[:product_type] == 1
         p = ::Product.fetch_product(product[:id]) 
         ComboProduct.create({:img_url => p[:data][:image], :price => product[:price],
          :combo_id => @combo.id, :brand_name => product[:brand_name], :category_name => product[:category_name], :product_type => 1})
        else
          ComboProduct.create({:img_url => product[:image], :price => product[:price],
          :combo_id => @combo.id, :brand_name => product[:brand_name], :category_name => product[:category_name], :product_type => 2})
        end
      end

      @remote_combo[:data][:images].each do |pic|
        ComboPic.create({:url => pic, :combo_id => @combo.id})
      end 
    end

    render :action => :new
  end

  def update
    @combo = ::Combo.find(params[:id])
    @combo.update_attributes(params[:combo])

    if params[:remote_id].present?
      @remote_combo = Ims::Combo.update(request, @combo.api_attrs.merge({:id => params[:remote_id]}))
    else
      @remote_combo = Ims::Combo.create(request, @combo.api_attrs)
    end
  end

  def add_img
    @combo = ::Combo.find(params[:id])
    @image = Ims::Combo.upload_img(request, {:image => params[:img], :image_type => 15})

    if @image[:isSuccessful]
      img = ComboPic.create({remote_id: @image[:data][:id], url: @image[:data][:url], :combo_id => @combo.id})
      json = {"status" => 1, "img" => @image[:data][:url], "id" => img.id}.to_json
    else
      json = {"status" => 0}.to_json
    end

    render :json => json
  end

  def remove_img
    @img = ::ComboPic.find(params[:img_id])
    @img.destroy

    render :json => {"status" => 1}.to_json
  end

  def remove_product
    @product = ::ComboProduct.find(params[:product_id])
    @product.destroy

    render :json => {"status" => 1}.to_json
  end

  def update_desc
    @combo = ::Combo.find(params[:id])
    @combo.update_attribute(:desc, params[:desc])

    render :json => {status: "200"}.to_json
  end


end
