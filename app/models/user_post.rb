class UserPost < ApplicationRecord
  belongs_to :user
  belongs_to :bbs_thread
  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true
  validates :bbs_thread_id, presence: true
  
end
