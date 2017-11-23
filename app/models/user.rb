class User < ApplicationRecord
  after_create :send_email_sign_up

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :lockable, :timeoutable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  scope :select_id_name_email_avatar, ->{select :id, :name, :email, :date_of_birth, :is_admin}
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

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.create_from_google_data(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end
end
