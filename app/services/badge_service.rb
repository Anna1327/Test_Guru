# frozen_string_literal: true

class BadgeService
  RULES_MAP = {
    category: BadgeAssignmentSpecifications::CategorySpecification,
    level: BadgeAssignmentSpecifications::LevelSpecification,
    first_try: BadgeAssignmentSpecifications::FirstTrySpecification
  }.freeze

  def initialize(test_passage)
    @test_passage = test_passage
    @user = @test_passage.user
    @user_completed_tests = TestPassage.where(user_id: @user.id, passed: true)
  end

  def check_completed_test
    gain_badges if @user_completed_tests.presence
  end

  private

  def gain_badges
    Badge.all.select do |badge|
      if RULES_MAP[badge.rule.to_sym].new(badge: badge, test_passage: @test_passage).win?
        @user.user_badges.create!(badge_id: badge.id)
      end
    end
  end
end