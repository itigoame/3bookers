class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_one_attached :profile_image

  has_many :books
  #　フォローされた
  has_many :followers, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # フォローした
  has_many :followings, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy

  # フォロワー一覧表示
  has_many :follower_users,  through: :followings, source: :followed
  # フォロー一覧表示
  has_many :following_users, through: :followers, source: :follower

  # フォロー
  def follow(user)
    followings.create(followed_id: user_id)
  end
  # フォロー解除
  def unfollow(user)
    followings.find_by(followed_id: user_id).destroy
  end
  # フォロー中か確認
  def following?(user)
    followings.include?(user)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

end
