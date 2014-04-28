# encoding: utf-8
module Front::CommentHelper

  def href_of_comment_item(comment)
    case comment[:sourcetype].to_i
    when 1
      front_product_path(comment[:sourceid])
    when 2
      front_promotion_path(comment[:sourceid])
    end
  end
end
