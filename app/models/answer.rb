# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validates :body, presence: true
  validate :validate_answers_amount, on: :create

  private

  def validate_answers_amount
    errors.add(:answers_amount, 'Answers limit reached') if question.answers.count > 4
  end
end
