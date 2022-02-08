# frozen_string_literal: true

require 'digest/sha1'
require 'uri'

class User < ApplicationRecord

  CHECK_EMAIL = URI::MailTo::EMAIL_REGEXP

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :tests, class_name: "Test", foreign_key: "author_id", dependent: :destroy

  validates :first_name, presence: true
  validates :email, presence: true, format: { with: CHECK_EMAIL }, uniqueness: true

  has_secure_password
  
  def get_tests(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
