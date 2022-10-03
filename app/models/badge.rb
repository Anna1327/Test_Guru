class Badge < ApplicationRecord
  has_many :user_badges, dependent: :nullify
  has_many :users, through: :user_badges
  
  validates :title, presence: true
  validates :image_url, presence: true
end
