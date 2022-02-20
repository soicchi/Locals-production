class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  include DeviseTokenAuth::Concerns::User
  # include Rails.application.routes.url_helpers

  has_many :posts,                  dependent: :destroy
  has_many :active_relationships,   class_name: 'Relationship',
                                    foreign_key: 'follower_id',
                                    dependent: :destroy
  has_many :passive_relationships,  class_name: 'Relationship',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
  has_many :following,              through: :active_relationships,
                                    source: :followed
  has_many :followers,              through: :passive_relationships
  has_many :book_marks,             dependent: :destroy
  has_many :book_mark_posts,        through: 'book_marks',
                                    source: :post
  has_many :likes,                  dependent: :destroy
  has_many :liked_posts,            through: 'likes',
                                    source: :post
  has_many :dislikes,               dependent: :destroy
  has_many :disliked_posts,         through: 'dislikes',
                                    source: :post
  # has_one_attached :avatar,         dependent: :destroy

  validates :name,         presence: true,
                           uniqueness: true,
                           length: { maximum: 10 }
  VALID_EMAIL_FORMAT = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/
  validates :email,        presence: true,
                           uniqueness: { case_sensitive: false },
                           format: { with: VALID_EMAIL_FORMAT }
  validates :birth_place,  presence: true
  validates :birth_year,   presence: true
  validates :birth_month,  presence: true
  validates :birth_day,    presence: true
  validates :gender,       presence: true
  validates :introduction, length: { maximum: 255 },
                           allow_nil: true
  # validates :avatar,       content_type: { in: %w[image/jpeg image/png image/gif image/jpg],
  #                                          message: '正しいフォーマットを選択してください' },
  #                          size: { less_than: 5.megabytes,
  #                                  message: '5MB以下のファイルサイズを選んでください' }

  # ユーザーをフォローする
  def follow(user)
    following << user
  end

  # ユーザーをフォロー解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def following_feed
    Post.where('user_id IN (?) OR user_id = ?', following_ids, id)
  end

  # ブックマークをする
  def book_mark(post)
    book_marks.create(post_id: post.id)
  end

  # ブックマークを外す
  def remove_book_mark(post)
    book_marks.find_by(post_id: post.id).destroy
  end

  # いいねをつける
  def like(post)
    likes.create(post_id: post.id)
  end

  # いいねをはずす
  def unlike(post)
    likes.find_by(post_id: post.id).destroy
  end

  # 投稿にいいねをしていたらtrueを返す
  def liked?(post)
    liked_posts.include?(post)
  end

  # 投稿にう〜ん...をつける
  def dislike(post)
    dislikes.create(post_id: post.id)
  end

  # 投稿のう〜ん...をはずす
  def undislike(post)
    dislikes.find_by(post_id: post.id).destroy
  end

  # 投稿にう〜ん...つけていたらtrueを返す
  def disliked?(post)
    disliked_posts.include?(post)
  end

  # # avatarのURLを返す
  # def avatar_url
  #   avatar.attached? ? rails_storage_proxy_url(avatar) : nil
  # end

  # #ユーザーの年齢を返す
  # def age
  #   birthday = Date.new(self.birth_year, self.birth_month, self.birth_day)
  #   birthday_value = (birthday.to_s.delete('-')).to_i
  #   today_value = (Date.today.to_s.delete('-')).to_i
  #   age = ((today_value - birthday_value) / 10000).floor
  # end
end
