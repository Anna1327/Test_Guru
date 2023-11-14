# frozen_string_literal: true

module BadgeAssignmentSpecifications
  class LevelSpecification < AbstractBadgeSpecification
    def win?
      return false if @condition.keys[0] != 'level'
      return false unless level_by_name(@condition.values[0]).include?(@test_passage.test.level)

      tests = Test.where(level: level_by_name(@condition.values[0]))
      passed_tests = TestPassage.where(user: @test_passage.user, test: tests, passed: true)
      tests.empty? || passed_tests.empty? ? false : (passed_tests.count % tests.count).zero?
    end
  end
end