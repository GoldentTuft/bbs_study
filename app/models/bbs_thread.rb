class BbsThread < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true
  default_scope -> { order(updated_at: :desc) }
  has_many :user_posts, dependent: :destroy
  has_many :anonymous_posts, dependent: :destroy
end
