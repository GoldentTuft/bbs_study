class Watch < ApplicationRecord
  belongs_to :user
  belongs_to :bbs_thread
  validates :user_id, presence: true
  validates :bbs_thread_id, presence: true
end
