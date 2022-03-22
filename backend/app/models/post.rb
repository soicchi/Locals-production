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
  has_many :evaluations,     dependent: :destroy
  has_many :tastes,          through: 'evaluations'

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
  validates :taste_ids, presence: true, length: { minimum: 1 }

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
    like_count = like_users.length.to_f
    total_count = like_users.length.to_f + dislike_users.length.to_f
    percent = like_count / total_count * 100
    if total_count == 0.0
      0
    else
      percent.round
    end
  end

  # 引数に入れた要素に対して年代別ユーザーグループを返す（例：いいねをした年代別ユーザー、う〜んの評価をした年代別ユーザーなど）
  def age_group(user_group)
    the_10s = user_group.select { |user| user.age < 20 }.length
    the_20s = user_group.select { |user| user.age >= 20 && user.age < 30 }.length
    the_30s = user_group.select { |user| user.age >= 30 && user.age < 40 }.length
    the_40s = user_group.select { |user| user.age >= 40 && user.age < 50 }.length
    the_50s = user_group.select { |user| user.age >= 50 && user.age < 60 }.length
    over_60s = user_group.select { |user| user.age >= 60 }.length
    [the_10s, the_20s, the_30s, the_40s, the_50s, over_60s]
  end

  # 各年代のいいね率を返す
  def favorite_rate_group
    favorite_rate_group = []
    i = 0
    age_group(like_users).length.times do
      total_age_group = age_group(like_users)[i] + age_group(dislike_users)[i]
      percent = age_group(like_users)[i].to_f / total_age_group.to_f * 100
      if total_age_group == 0.0
        favorite_rate_group.push(0)
      else
        favorite_rate_group.push(percent.round)
      end
      i += 1
    end
    favorite_rate_group
  end
end
