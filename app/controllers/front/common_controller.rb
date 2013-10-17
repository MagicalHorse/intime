class Front::CommonController < Front::BaseController

  def hotwords
    stores   = Stage::Store.list
    brands   = Stage::Brand.group_brands
    tags     = Stage::Tag.list
    hotwords = Stage::HotWord.list
    render :json => stores.merge(brands).merge(tags).merge(hotwords).to_json, callback: params[:callback] 
  end
end
