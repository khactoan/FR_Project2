class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  acts_as_taggable

  validates :title, presence: true
  validates :content, presence: true

  scope :id_select_title_description_created_at_user, ->{select :id, :title,
    :description, :user_id, :created_at}
  scope :order_by_created_at, ->{order created_at: :desc}

  def has_comments?
    self.comments.count > 0
  end
end
