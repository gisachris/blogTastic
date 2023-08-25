class Post < ApplicationRecord
  validates :title, presence: true, length: (1..250)
  validates :comments_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :likes_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  after_save :update_post_counter

  private

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
