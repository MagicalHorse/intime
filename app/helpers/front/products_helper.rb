module Front::ProductsHelper
  def images_resource(p)
    p.resource.select{|r| r[:type]==1}
  end
  def audio_resource(p)
    @product.resource.select{|r| r[:type]==2}
  end
end
