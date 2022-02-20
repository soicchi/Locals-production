class Classification < ApplicationRecord
  belongs_to :post
  belongs_to :category

  validates :category_id, presence: true
  validates_uniqueness_of :post_id, scope: :category_id

  # category_idsに合致するpost_idを含むカラムを取得する
  def self.match_all_categories(category_ids)
    where(category_id: category_ids).select(:post_id).group(:post_id).having('count(post_id) = ?', category_ids.length).map(&:post_id)
  end
end
