class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :comments
  acts_as_taggable

  def has_comments?
    self.comments.count > 0
  end
end
