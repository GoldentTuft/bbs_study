class BbsThread < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true
  default_scope -> { order(updated_at: :desc) }
  has_many :user_posts, dependent: :destroy
  has_many :anonymous_posts, dependent: :destroy
  
  def push_post(post_item)
    self.update_attributes(total_posted: self.total_posted + 1)
    post_item.post_number = self.total_posted
    post_item.bbs_thread_id = self.id
    if post_item.save
      return true
    else
      self.update_attributes(total_posted: self.total_posted - 1)
      return false
    end
  end
  
  def last_post
    user_post = self.user_posts.last
    anonymous_post = self.anonymous_posts.last
    unless anonymous_post
      return user_post
    end
    unless user_post
      return anonymous_post
    end
    if user_post.created_at >= anonymous_post.created_at
      return user_post
    else
      return anonymous_post
    end
  end
end
