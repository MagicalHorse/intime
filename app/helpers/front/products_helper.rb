module Front::ProductsHelper
  def images_resource(p)
    p.resource.select{|r| r[:type]==1}
  end
  def audio_resource(p)
    @product.resource.select{|r| r[:type]==2}
  end

  def display_promotion_image_url(promotion)
    Settings.default_image_url.product.small
    #if promotion.image_urls.present?
      #promotion.image_urls.first
    #else
      #Settings.default_image_url.product.small
    #end
  end
end
