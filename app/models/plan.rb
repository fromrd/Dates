class Plan < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :sample_flag, presence: true
  validates :image, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :review_users, through: :reviews, source: :user
  mount_uploader :image, ImageUploader
end
