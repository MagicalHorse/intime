# encoding: utf-8
class CommentController < ApplicationController
  def get_list
    render_items mock_up
  end

  protected

  def mock_up
   (1..9).inject([]) do |_r, _i|
      _r << {
        commentId:    _i,
        content:      '文本内容',
        createTime:   '2013-06-21 10:10',
        floor:        _i,
        customer:     {
          id:         1,
          nickname:   'kimi',
          logo:       'http://yt.seekray.net/0909/temp/noavatar_default.png',
          url:        'http://www.baidu.com'
        },
        comments: [
          {
            commentId:    _i,
            content:      '文本内容',
            createTime:   '2013-06-21 10:10',
            customer:     {
              id:         1,
              nickname:   'kimi',
              logo:       'http://yt.seekray.net/0909/temp/noavatar_default.png',
              url:        'http://www.baidu.com'
            }
          },
          {
            commentId:    _i,
            content:      '文本内容',
            createTime:   '2013-06-21 10:10',
            customer:     {
              id:         1,
              nickname:   'kimi',
              logo:       'http://yt.seekray.net/0909/temp/noavatar_default.png',
              url:        'http://www.baidu.com'
            }
          }
        ]
      }

      _r
    end
  end
end
