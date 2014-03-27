class Ims::Store::CombosController < Ims::Store::BaseController

  #新建搭配
  def new
    if params[:combo_id].present?
      @combo = ::Combo.find(params[:combo_id])
    else
      @combo = ::Combo.create
    end
  end

  def create
  end

  #查看搭配
  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
  end

  def tutorials
  end

  def edit
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @remote_id = @remote_combo[:data][:id]
    
    if params[:combo_id].present?
      @combo = ::Combo.find(params[:combo_id])
    else
      @combo = ::Combo.create({:desc => @remote_combo[:data][:desc], :private_to => @remote_combo[:data][:private_to],
       :combo_type => @remote_combo[:data][:combo_type]})

      @remote_combo[:data][:productids].each do |product|
        @combo.combo_products.create({:remote_id => product[:id], :image => product[:image]})
      end

      @remote_combo[:data][:image_ids].each do |pic|
        @combo.combo_pics.create({:remote_id => pic[:id], :url => pic[:url]})
      end 
    end

    render :action => :new
  end

  def update
    @combo = ::Combo.find(params[:id])
    @combo.update_attributes(params[:combo])

    if params[:remote_id].present?
      @remote_combo = Ims::Combo.update(request, combo.api_attrs.merge({:id => params[:remote_id]}))
    else
      @remote_combo = Ims::Combo.create(request, combo.api_attrs)
    end

    if @remote_combo[:isSuccessful]
      redirect_to ims_store_combo_path(id: @remote_combo[:data][:id])
    else
      render :action => :new
    end  
  end

  def add_img
    @combo = ::Combo.find(params[:id])
    @image = Ims::Combo.upload_img(request, {:image => params[:img]})

    if @image[:isSuccessful]
      img = @combo.combo_pics.create({remote_id: @image[:data][:id], url: @image[:data][:url]})
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


end
