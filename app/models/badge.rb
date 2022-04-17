class Badge < ApplicationRecord
  has_many :user_badges, dependent: :nullify
  has_many :users, through: :user_badges

  has_one_attached :image_url
  
  validates :title, presence: true
  validates :image_url, presence: true
end
