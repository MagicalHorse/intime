require 'test_helper'
require 'test/unit'

class CommentESTest < Test::Unit::TestCase
  # test "the truth" do
  #   assert true
  # end
 def test_subscribe_with_simple_data 
        CommentES.subscribe({:id=>1,:status=>1,:textmsg => 'test subscribe',
              :sourceid => 10000,
              :sourcetype => 1,
              :reply_id => 0,
              :user=>{:id=>1,:logo=>'test.jpg',:nickie=>'test',:level=>1}})
        CommentES.index.refresh

        results = CommentES.search 'test'
        assert_equal 'test subscribe', results.first.textmsg
 end
end
