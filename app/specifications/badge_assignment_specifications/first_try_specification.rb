# frozen_string_literal: true

module BadgeAssignmentSpecifications
  class FirstTrySpecification < AbstractBadgeSpecification
    def win?
      return false if @condition.keys[0] != 'first_try'

      tests_count = TestPassage.where(user: @test_passage.user, test: @test_passage.test).count
      @test_passage.passed? && tests_count == 1
    end
  end
end