class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  ## user_likeテーブル
  # A:user -> B:user_like(user_id)
  has_many :user_likes, class_name: "UserLike", foreign_key: :user_id
  # A:user -> C:user_like(user_id)
  has_many :likes, through: "user_likes"
  # C:user -> B:user_like(like_id)
  has_many :user_likers, class_name: "UserLike", foreign_key: :like_id
  # C:user -> A:user_like(user_id)
  has_many :likers, through: "user_likers"

  has_many :restaurants

  # Facebookから情報を取得する
  def self.find_for_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.gender = auth.extra.raw_info.gender
      user.thumb = "https://graph.facebook.com/"+auth.uid.to_s+"/picture?type=large"
      user.age_range = auth.extra.raw_info.age_range.min.last
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  # バリデーション設定
  # validates :password, presence: false, on: :facebook_login #Facebookログイン時
  # validates :name, presence: true, length: { maximum: 50 } # Userテーブルのnameカラム


  private
  # まだuserでない場合はダミーメール作成しユーザー情報を保存
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end