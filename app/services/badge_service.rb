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
      condition = JSON.parse badge.condition.gsub('=>', ':')

      if RULES_MAP[condition.keys[0].to_sym].new(badge: badge, test_passage: @test_passage, condition: condition).win?
        new_badge = @user.user_badges.new(badge_id: badge.id)
        new_badge.save
      end
    end
  end
end