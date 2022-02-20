class Post < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :user_id,         presence: true
  validates :comment,         presence: true, length: { maximum: 255 }
  validates :restaurant_name, presence: true
  validates :station,         presence: true
end
