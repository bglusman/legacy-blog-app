module ApplicationHelper
  def post_excerpt(post)
    post.body[0..100]
  end
end
