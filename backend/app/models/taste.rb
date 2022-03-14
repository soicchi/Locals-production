class Taste < ApplicationRecord
  has_many :preferences, dependent: :destroy
  has_many :users,       through: 'preferences'
  has_many :evaluations, dependent: :destroy
  has_many :posts,       through: 'evaluations'

  scope :order_asc, -> { order(:content) }

  validates :content, presence: true, uniqueness: true
end
