# encoding: utf-8
class Front::CommonController < Front::BaseController

  def hotwords
    hotwords = Stage::HotWord.list
  end

  def stores
    stores = Stage::Store.list
    result = hotwords.slice(:storewords).merge(stores)
    get_all_brands(results)
    render :json => result.to_json, callback: params[:callback]
  end

  def brands
    brands     = Stage::Brand.group_brands
    all_brands = get_all_brands(brands[:brands])
    result     = hotwords.slice(:brandwords).merge(brands).merge(all_brands)
    render :json => result.to_json, callback: params[:callback]
  end

  def tags
    tags   = Stage::Tag.list
    result = hotwords.slice(:words).merge(tags)
    render :json => result.to_json, callback: params[:callback]
  end


end
