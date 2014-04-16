# encoding: utf-8
class Ims::CombosController < Ims::BaseController
  layout "store"

  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @private_to = params[:private_to]
    @store_id = params[:store_id]
    @title = "搭配展示"
    @can_share = true
  end

  def upload
  	 imagedata = params[:img].split(',')[1]

  	 filename = 'uploads/'+ Time.now.to_i.to_s + '.jpg'
  	 File.open('public/'+filename, 'wb') do|f|
      f.write(Base64.decode64(imagedata))
    end

    @img_url = "#{Rails.root}/public/#{filename}"
    
    img = File.new("#{@img_url}", 'rb')
    @image = Ims::Combo.upload_img(request, {:image => img, :image_type => 15})
    binding.pry
    render :json => {"img_url" => @img}
  end
end