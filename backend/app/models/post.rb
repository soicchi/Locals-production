class Post < ApplicationRecord
  # include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :book_marks,      dependent: :destroy
  has_many :book_mark_users, through: 'book_marks',
                             source: :user
  has_many :likes,           dependent: :destroy
  has_many :like_users,      through: 'likes',
                             source: :user
  has_many :dislikes,        dependent: :destroy
  has_many :dislike_users,   through: 'dislikes',
                             source: :user
  has_many :classifications, dependent: :destroy
  has_many :categories,      through: 'classifications'
  # has_many_attached :images, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id,         presence: true
  validates :comment,         presence: true, length: { maximum: 255 }
  validates :restaurant_name, presence: true
  validates :station,         presence: true
  validates :category_ids, presence: true
  # validates :images, content_type: { in: %w[image/png image/gif image/jpeg image/jpg],
  #                                    message: '正しいフォーマットのファイルを選択してください' },
  #                    size: { less_than: 20.megabytes,
  #                            message: '20MB以下のファイルを選択してください' },
  #                    attached: true

  # # imagesのURLを返す（仮）
  # def image_url
  #   image_url = []
  #   images.blobs.each do |image|
  #     image_url.unshift(rails_storage_proxy_url(image))
  #   end
  #   image_url
  # end

  # いいねしているユーザーの人数を年代別で抽出
  def liked_age_group
    the_10s = self.like_users.select { |user| user.age < 20 }.length
    the_20s = self.like_users.select { |user| user.age >= 20 && user.age < 30 }.length
    the_30s = self.like_users.select { |user| user.age >= 30 && user.age < 40 }.length
    the_40s = self.like_users.select { |user| user.age >= 40 && user.age < 50 }.length
    the_50s = self.like_users.select { |user| user.age >= 50 && user.age < 60 }.length
    over_60s = self.like_users.select { |user| user.age >= 60 }.length
    [the_10s, the_20s, the_30s, the_40s, the_50s, over_60s]
  end

  # う〜んしているユーザーの人数を年代別で抽出
  def disliked_age_group
    the_10s = self.dislike_users.select { |user| user.age < 20 }.length
    the_20s = self.dislike_users.select { |user| user.age >= 20 && user.age < 30 }.length
    the_30s = self.dislike_users.select { |user| user.age >= 30 && user.age < 40 }.length
    the_40s = self.dislike_users.select { |user| user.age >= 40 && user.age < 50 }.length
    the_50s = self.dislike_users.select { |user| user.age >= 50 && user.age < 60 }.length
    over_60s = self.dislike_users.select { |user| user.age >= 60 }.length
    [the_10s, the_20s, the_30s, the_40s, the_50s, over_60s]
  end
end
