# encoding: utf-8
module Front::ProductsHelper
  def images_resource(p)
    p.resource.select{|r| r[:type]==1}
  end
  def audio_resource(p)
    @product.resource.select{|r| r[:type]==2}
  end

  def display_promotion_image_url(promotion)
    if (resource = promotion.resource[0]).present?
      [PIC_DOMAIN, resource.name, "_320X0.jpg"].join('')
    else
      Settings.default_image_url.product.small
    end
  end

  def format_price(price)
    "%.2f" % price
  end
end
