require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :users, :resources, :comments, :products
  test "can create comment" do
    comment_one = Comment.new(:status=>comments(:one).status,
                      :textmsg=>comments(:one).textmsg,
                      :reply_id=>comments(:one).reply_id,
                      :source_id=>comments(:one).source_id,
                      :source_type=>comments(:one).source_type,
                      :user_id=>comments(:one).user_id)
     assert comment_one.save
  end
  
  test "find parent comment" do
    replies = Comment.find(comments(:one).id).replies
    
    assert replies.length == 1
    assert replies.first.id == comments(:two).id
  end
  
  test "find parent source product" do
    product = Comment.find(comments(:one).id).source
    assert_equal product.id, products(:one).id
  end
end
