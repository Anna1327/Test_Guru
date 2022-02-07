# frozen_string_literal: true

class Test < ApplicationRecord
  POSITIVE_INFINITY = Float::INFINITY

  belongs_to :category
  belongs_to :author, class_name: 'User'

  has_many :questions, dependent: :destroy
  has_many :user_tests, dependent: :destroy
  has_many :users, through: :user_tests
  
  scope :simple, -> { where(level: 0..1) }
  scope :middle, -> { where(level: 2..4) }
  scope :complex, -> { where(level: 5..POSITIVE_INFINITY) }
  scope :sort_by_category, lambda { |category_name|
                              joins(:category)
                              .where(categories: { title: category_name })
                            }
  
  validates :title, presence: true
  validates :level, numericality: { only_integer: true, greater_than: -1 }

  def self.category_title_with_order(category_name)
    sort_by_category(category_name).order(title: :DESC).pluck(:title)
  end
end
