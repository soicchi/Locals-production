class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

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
  has_many_attached :images, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :user_id,         presence: true
  validates :comment,         presence: true, length: { maximum: 255 }
  validates :restaurant_name, presence: true
  validates :station,         presence: true
  validates :category_ids, presence: true
  validates :images, content_type: { in: %w[image/png image/gif image/jpeg image/jpg],
                                     message: '正しいフォーマットのファイルを選択してください' },
                     size: { less_than: 5.megabytes,
                             message: '5MB以下のファイルを選択してください' },
                     attached: true

  # imagesのURLを返す
  def image_url
    i = 0
    count = images.length
    image_list = []
    while i < count
      image_list.unshift(rails_storage_proxy_url(images[i].variant(resize_to_limit: [200, 200])))
      i += 1
    end
    image_list
  end

  # 投稿のいいね比率を返す
  def like_percentage
    like_count = like_users.length
    dislike_count = dislike_users.length
    percent = like_count / (like_count + dislike_count) * 100
    if !percent
      0
    else
      percent.round
    end
  end

  # いいねしているユーザーの人数を年代別で抽出
  def liked_age_group
    the_10s = like_users.select { |user| user.age < 20 }.length
    the_20s = like_users.select { |user| user.age >= 20 && user.age < 30 }.length
    the_30s = like_users.select { |user| user.age >= 30 && user.age < 40 }.length
    the_40s = like_users.select { |user| user.age >= 40 && user.age < 50 }.length
    the_50s = like_users.select { |user| user.age >= 50 && user.age < 60 }.length
    over_60s = like_users.select { |user| user.age >= 60 }.length
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
