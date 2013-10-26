class Front::CommonController < Front::BaseController

  def hotwords
    hotwords = Stage::HotWord.list
  end

  def stores
    stores = Stage::Store.list
    result = hotwords.slice(:storewords).merge(stores)
    render :json => result.to_json, callback: params[:callback]
  end

  def brands
    brands = Stage::Brand.group_brands
    result = hotwords.slice(:brandwords).merge(brands)
    render :json => result.to_json, callback: params[:callback]
  end

  def tags
    tags   = Stage::Tag.list
    result = hotwords.slice(:words).merge(tags)
    render :json => result.to_json, callback: params[:callback]
  end

end
