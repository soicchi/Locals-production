class Taste < ApplicationRecord
  has_many :preferences, dependent: :destroy
  has_many :users,       through: 'preferences'

  validates :content, presence: true, uniqueness: true
end
