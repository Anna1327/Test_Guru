# frozen_string_literal: true

class BadgesController < ApplicationController
  def index
    @badges = current_user.user_badges
  end
end
