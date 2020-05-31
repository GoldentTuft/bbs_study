class BbsThread < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }
  default_scope -> { order(created_at: :desc) }
end
