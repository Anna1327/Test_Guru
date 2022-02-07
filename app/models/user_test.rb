# frozen_string_literal: true

class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test
end
