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
    @combo = ::Combo.find(params[:id])
    Ims::Combo.create(request, @combo)
    redirect_to "/ims/store/combos/1"
  end

  #查看搭配
  def show
    
  end

  def tutorials
  end

  def edit
    # combo = Ims::Combo.show(params[:id])
    # @combo = Combo.find(params[:combo_id]) ||= Combo.create()
  end

  def update
    redirect_to :action => :show    
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
