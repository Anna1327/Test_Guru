# frozen_string_literal: true

module BadgeAssignmentSpecifications
  class CategorySpecification < AbstractBadgeSpecification
    def win?
      return false if @condition.keys[0] != 'category'
      return false unless @condition.values[0] == @test_passage.test.category.title

      category = Category.where(title: @condition.values[0]).first
      tests = Test.where(category_id: category.id)
      passed_tests = TestPassage.where(user: @test_passage.user, test: tests, passed: true)
      tests.empty? || passed_tests.empty? ? false : (passed_tests.count % tests.count).zero?
    end
  end
end