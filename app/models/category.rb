# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :tests, dependent: :destroy
  has_many :badge_rules, dependent: :destroy

  default_scope { order(title: :asc) }

  validates :title, presence: true
end
