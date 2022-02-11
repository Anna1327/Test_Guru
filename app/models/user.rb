# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, 
        :registerable,
        :recoverable, 
        :rememberable, 
        :validatable,
        :confirmable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :tests, class_name: "Test", foreign_key: "author_id", dependent: :destroy
  has_many :gists, class_name: "Gist", foreign_key: "author_id", dependent: :destroy
  
  def get_tests(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    self.is_a?(Admin)
  end
end
