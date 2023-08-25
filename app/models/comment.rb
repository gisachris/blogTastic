class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def comment_updater
    post.update(comments_counter: post.comments.count)
  end
end
