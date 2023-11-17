# frozen_string_literal: true

module BadgeAssignmentSpecifications
  class LevelSpecification < AbstractBadgeSpecification
    def win?
      return false unless level_by_name(@badge.value).include?(@test_passage.test.level)

      tests = Test.where(level: level_by_name(@badge.value))
      passed_tests = TestPassage.where(user: @test_passage.user, test: tests, passed: true)
      tests.empty? || passed_tests.empty? ? false : (passed_tests.count % tests.count).zero?
    end
  end
end