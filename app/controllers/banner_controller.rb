# encoding: utf-8
class BannerController < ApplicationController
 # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands
  def list
    page_index_in = params[:page]
    page_size_in = params[:pagesize]

    return render :json=>Banner.list_by_page({
      :page=>params[:page],
      :pagesize=>params[:pagesize]
    }).to_json()
    
  end
end
