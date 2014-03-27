class Ims::ProductSize < Ims::Base

  class << self
    def list(req, params={})
      category_id = params[:category_id]
      categories = Ims::ProductCategory.list(req)["data"]["items"]
      categories.find{|obj| obj['id'].to_s == category_id.to_s}["sizes"]
    end
  end

end