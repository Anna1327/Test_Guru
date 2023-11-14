# frozen_string_literal: true

module BadgeAssignmentSpecifications
  class CategorySpecification < AbstractBadgeSpecification
    def win?
      return false if @condition.keys[0] != 'category_id'
      return false unless @condition.values[0].to_i == @test_passage.test.category.id

      tests = Test.where(category_id: @condition.values[0])
      passed_tests = TestPassage.where(user: @test_passage.user, test: tests, passed: true)
      tests.empty? || passed_tests.empty? ? false : (passed_tests.count % tests.count).zero?
    end
  end
end