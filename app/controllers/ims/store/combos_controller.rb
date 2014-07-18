# encoding: utf-8

class Ims::Store::CombosController < Ims::Store::BaseController
  before_filter :goto_combo, only: :edit

  def new
    @combo = ::Combo.find_by_id(params[:combo_id]) || @combo = ::Combo.create
    @request_iphone = request.user_agent.downcase.include?("iphone")
    @title = "新建组合"
  end

  def destroy
    @status = Ims::Combo.delete(request, {id: params[:id]})
    render json: {status: @status[:isSuccessful], message: @status[:message]}.to_json
  end

  def show
    @title = "组合详情"
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
  end

  def update_desc
    @combo = ::Combo.find(params[:id])
    @combo.update_attributes({desc: params[:desc], private_to: params[:private_to]})
    render json: {status: "ok"}.to_json
  end

  def preview
    @combo = ::Combo.find(params[:id])
    @title = "组合预览"
  end

  def edit
    @remote_id = @remote_combo[:data][:id]
    @title = "修改组合"

    if params[:combo_id].present?
      @combo = ::Combo.find(params[:combo_id])
    else
      @combo = ::Combo.create({
        desc: @remote_combo[:data][:desc],
        private_to: @remote_combo[:data][:private_desc],
        combo_type: @remote_combo[:data][:combo_type],
        remote_id: @remote_combo[:data][:id],
        discount: @remote_combo[:data][:discount],
        has_discount: @remote_combo[:data][:discount] > 0 ? true : false,
        is_public: @remote_combo[:data][:is_public]
      })

      @remote_combo[:data][:products].each do |product|
        options = {
          price: product[:price],
          combo_id: @combo.id,
          brand_name: product[:brand_name],
          category_name: product[:category_name],
          remote_id: product[:id]
        }
        if product[:product_type].blank? || product[:product_type] == 1
          p = ::Product.fetch_product(product[:id])
          ComboProduct.create(options.merge({img_url: p[:data][:image], product_type: 1})) if p.present?
        else
          ComboProduct.create(options.merge({img_url: product[:image], product_type: 2}))
        end
      end

      @remote_combo[:data][:images].each do |img|
        ComboPic.create({url: img["name"], combo_id: @combo.id, remote_id: img["id"]})
      end
    end

    render "new"
  end

  def update
    @combo = ::Combo.find(params[:id])
    @combo.update_attributes(params[:combo])
    if @combo.remote_id.present?
      @remote_combo = Ims::Combo.update(request, @combo.api_attrs.merge({:id => @combo.remote_id}))
    else
      @remote_combo = Ims::Combo.create(request, @combo.api_attrs)
    end
  end

  def add_img
    @combo = ::Combo.find(params[:id])
    @image = Ims::Combo.upload_img(request, {:image => params[:img], :image_type => 15})

    if @image[:isSuccessful]
      img = ComboPic.create({remote_id: @image[:data][:id], url: @image[:data][:url], combo_id: @combo.id})
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
    @combo.update_attributes(
      desc: params[:desc],
      private_to: params[:private_to],
      has_discount: params[:has_discount],
      discount: params[:discount],
      is_public: params[:is_public]
    )
    render :json => {status: "200"}.to_json
  end

  private

  def goto_combo
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    redirect_to ims_combo_path(id: params[:id], t: Time.now.to_i) if current_user.id != @remote_combo[:data][:owner_id]
  end

end
