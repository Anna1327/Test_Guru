# frozen_string_literal: true

module BadgeAssignmentSpecifications
  class CategorySpecification < AbstractBadgeSpecification
    def win?
      return false unless @badge.value == @test_passage.test.category.title

      tests = Test.joins(:category).where(category: { title: @badge.value })
      passed_tests = TestPassage.where(user: @test_passage.user, test: tests, passed: true)
      tests.empty? || passed_tests.empty? ? false : (passed_tests.count % tests.count).zero?
    end
  end
end