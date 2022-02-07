# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tests, class_name: "Test", foreign_key: "author_id", dependent: :destroy
  has_many :user_tests, dependent: :destroy
  has_many :tests, through: :user_tests
  
  def get_tests(level)
    tests.where(level: level)
  end
end
