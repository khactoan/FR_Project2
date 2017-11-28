class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_taggable

  validates :title, presence: true, length: {maximum: Settings.title.maxlength}
  validates :description, length: {maximum: Settings.description.maxlength}
  validates :content, presence: true

  scope :id_select_title_description_created_at_user, ->{select :id, :title,
    :description, :user_id, :created_at, :updated_at}
  scope :order_by_created_at, ->{order created_at: :desc}

  def has_comments?
    self.comments.count > 0
  end

  class << self
    def interested_posts user_id
      query = "SELECT id, title, description, user_id, created_at, updated_at
        FROM posts WHERE posts.user_id in (SELECT followed_id FROM relationships
        WHERE follower_id = #{user_id}) ORDER BY created_at DESC"
      self.find_by_sql query
    end
  end
end
