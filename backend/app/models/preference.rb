class Preference < ApplicationRecord
  belongs_to :user
  belongs_to :taste

  validates :user_id, presence: true
  validates :taste_id, presence: true
  validates_uniqueness_of :user_id, scope: :taste_id
end
