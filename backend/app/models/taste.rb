class Taste < ApplicationRecord
  validates :content, presence: true, uniqueness: true
end
