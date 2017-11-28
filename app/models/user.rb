class User < ApplicationRecord
  after_create :send_email_sign_up

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :timeoutable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  scope :select_id_name_email_avatar, ->{select :id, :name, :email,
    :date_of_birth, :is_admin}
  scope :order_by_created_at, ->{order created_at: :desc}
  scope :select_others, ->user {where "id != ?", user.id}

  def send_email_sign_up
    SystemMailer.sign_up_email(self).deliver_now!
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  class << self
    def create_from_provider_data provider_data
      if where(email: provider_data.info.email).exists?
        return_user = self.where(email: provider_data.info.email).first
        return_user.provider = provider_data.provider
        return_user.uid = provider_data.uid

        return_user
      else
        where(provider: provider_data.provider, uid: provider_data.uid)
          .first_or_create do | return_user |
          return_user.email = provider_data.info.email
          return_user.password = 123456
        end
      end
    end

    def create_from_google_data access_token
      data = access_token.info
      return_user = User.where(email: data["email"]).first

      unless return_user
        return_user = User.create name: data["name"], email: data["email"],
         password: 123456
      end

      return_user
    end
  end
end
