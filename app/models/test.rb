# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'

  has_many :questions, dependent: :destroy
  has_many :user_tests, dependent: :destroy
  has_many :users, through: :user_tests
  
  def self.sort_by_category(category_name)
    joins(:category).where(categories: { title: category_name }).order(title: :DESC).pluck(:title)
  end
end
