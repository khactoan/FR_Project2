class Comment < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :post, dependent: :destroy

  validates :content, presence: true
  validates :user, presence: true
  validates :post, presence: true

  scope :select_id_user_post_content_created_at_updated_at,
    ->{select :id, :user_id, :post_id, :content, :created_at, :updated_at}
  scope :order_by_created_at, ->{order created_at: :desc}
  scope :comment_for_this_post, -> post {where "post_id = ?", post.id}
end
