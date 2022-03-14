class Taste < ApplicationRecord
  has_many :preferences, dependent: :destroy
  has_many :users,       through: 'preferences'
  has_many :evaluations, dependent: :destroy
  has_many :posts,       through: 'evaluations'

  validates :content, presence: true, uniqueness: true
end
