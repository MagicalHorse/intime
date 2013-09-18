# encoding: utf-8
class ProfileController < ApplicationController

  def get_list
    result = {}
    result[:loveType] = params[:loveType]
    render_items(mock_up,result)
  end

  private

  def mock_up

   (1..9).inject([]) do |_r, _i|
      _r << {
        title:          '开衫连帽卫衣 ASDF335 -2 黛紫色',
        imageUrl:       'http://yt.seekray.net/0909/temp/440_350_1.jpg',
        url:            'http://www.baidu.com',
        price:          11,
        originalPrice:  22,
        likeCount:      900,
      }

      _r
    end
  end

end
