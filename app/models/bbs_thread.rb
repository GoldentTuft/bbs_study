class BbsThread < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true
  default_scope -> { order(updated_at: :desc) }
  has_many :user_posts, dependent: :destroy
  has_many :anonymous_posts, dependent: :destroy
  has_many :watches, foreign_key: "bbs_thread_id", dependent: :destroy
  has_many :followers, through: :watches, source: :user
  
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
  
  def all_posts
    res = self.user_posts +  self.anonymous_posts
    res.sort! do |f,s|
      if !f || !f.created_at
        1
      elsif !s || !s.created_at
        -1
      else
        f.created_at <=> s.created_at
      end
    end
    return res
  end
  
  def page_count
    sum = self.user_posts.count + self.anonymous_posts.count
    return sum / WillPaginate.per_page + 1
  end
  
  def last_post
    last_posts = [
        self.user_posts.last,
        self.anonymous_posts.last
      ]
      
    return last_posts.compact.max do |a, b|
      a.created_at <=> b.created_at
    end
  end
  
  def count_post
    self.user_posts.count + self.anonymous_posts.count
  end
end
