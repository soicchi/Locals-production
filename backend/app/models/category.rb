class Category < ApplicationRecord
  has_many :classifications, dependent: :destroy
  has_many :posts,           through: 'classifications'

  scope :order_asc, -> { order(:name) }

  validates :name, presence: true, uniqueness: true

  def self.order_category_list
    category_list = []
    categories = where('name != ?', 'その他').order_asc
    categories.each do |category|
      category_list.push(category)
    end
    other_category = find_by(name: 'その他')
    category_list.push(other_category)
    category_list
  end
end
