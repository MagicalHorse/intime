# encoding: utf-8
class Ims::CombosController < Ims::BaseController
  layout "store"

  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @private_to = params[:private_to]
    @store_id = params[:store_id]
    @title = "搭配展示"
    @can_share = true
    session[:store_id] = @remote_combo[:data][:store_id]
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
end