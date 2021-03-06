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

  ## user_likeテーブル
  # A:user -> B:user_like(user_id)
  has_many :messages, class_name: "Message", foreign_key: :sender_id
  # A:user -> C:user_like(user_id)
  has_many :senders, through: "messages"
  # C:user -> B:user_like(like_id)
  has_many :messages, class_name: "Message", foreign_key: :receive_id
  # C:user -> A:user_like(user_id)
  has_many :receivers, through: "massages"

  has_many :restaurants
  has_many :user_friends

  # Facebookから情報を取得する
  def self.find_for_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.gender = auth.extra.raw_info.gender
      user.thumb = "https://graph.facebook.com/"+auth.uid.to_s+"/picture?type=large"
      user.age_range = auth.extra.raw_info.age_range.min.last
      # user.birthday = Date.strptime(auth.extra.raw_info.birthday, "%m/%d/%Y") if auth.extra.raw_info.birthday
      user.birthday = auth.extra.raw_info.birthday





      logger.info "=================================================================================================================================================================================================================================================================================================================================================================================================================================="
      logger.info "authの中身"
      logger.info auth
      logger.info "auth.extraの中身"
      logger.info auth.extra
      logger.info "auth.extra.raw_infoの中身"
      logger.info auth.extra.raw_info
      logger.info "=================================================================================================================================================================================================================================================================================================================================================================================================================================="
      # @friends = auth.extra.raw_info.friends.data # 中に入るのは"name"と"id"
      # user.image = auth.info.image # assuming the user model has an image
      # user.education = auth.user_education_history.name
      # user.work = auth.user_work_history.name

    end
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user_friend|
      user_friend.uid = auth.extra.raw_info.friends.data.id
      user_friend.name = auth.extra.raw_info.friends.data.name
      user_friend.user = auth.uid
      logger.info "=================================================================================================================================================================================================================================================================================================================================================================================================================================="
      logger.info "user_friendの中身"
      logger.info user_friend
      logger.info "=================================================================================================================================================================================================================================================================================================================================================================================================================================="

    end
  end

  # パスワードなしで編集の許可
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # バリデーション設定
  # validates presence: false, on: :facebook_login #Facebookログイン時
  validates :name, :age_range , presence: true, length: { maximum: 50 } # Userテーブルのnameカラム

  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
