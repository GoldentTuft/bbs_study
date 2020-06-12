class AnonymousPost < ApplicationRecord
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  belongs_to :bbs_thread
  validates :content, presence: true, length: { maximum: 5000 }
  validates :bbs_thread_id, presence: true
  
  # 渡された文字列のハッシュ値を返す
  def AnonymousPost.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def AnonymousPost.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def nickname
    unless self.name.blank?
      return self.name
    else
      return '名無し'
    end
  end
  
  def content_for_catalog
    self.content.truncate(140)
  end
  
end
