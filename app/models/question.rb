# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy
  has_many :current_question, class_name: "TestPassage", foreign_key: "current_question_id", dependent: :destroy

  validates :body, presence: true
end
