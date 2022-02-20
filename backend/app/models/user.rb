# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, dependent: :destroy

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
end
