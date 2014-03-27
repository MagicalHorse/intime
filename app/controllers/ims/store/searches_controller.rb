class Ims::Store::SearchesController < Ims::Store::BaseController

  def index
    @searches = Ims::Product.search(request, type: params["type"], from: params["form"], to: params["to"], id: params["brand_id"], keywords: params["keywords"])["data"]["items"]
    @products = @searches.group_by{|obj| obj["create_date"].to_date}.values
    @brands = Ims::ProductBrand.list(request)["data"]["items"]
  end

  def show

  end

  def edit

  end



end