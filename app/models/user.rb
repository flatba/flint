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

  # self.find_for_oauthを定義
  # callback後のユーザー登録で、取得した情報を参照する。
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  #...

  # allow users to update their accounts without passwords
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
  # まだuserでない場合はダミーメール作成しユーザー情報を保存
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
