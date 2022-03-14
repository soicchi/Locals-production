class Evaluation < ApplicationRecord
  belongs_to :post
  belongs_to :taste

  validates :taste_id, presence: true
  validates_uniqueness_of :post_id, scope: :taste_id
end
