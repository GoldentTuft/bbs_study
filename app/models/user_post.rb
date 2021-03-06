class UserPost < ApplicationRecord
  belongs_to :user
  belongs_to :bbs_thread
  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true
  validates :bbs_thread_id, presence: true
  
  def content_for_catalog
    self.content.truncate(140)
  end
end
