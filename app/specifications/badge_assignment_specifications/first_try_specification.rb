# frozen_string_literal: true

module BadgeAssignmentSpecifications
  class FirstTrySpecification < AbstractBadgeSpecification
    def win?
      tests_count = TestPassage.where(user: @test_passage.user, test: @test_passage.test).count
      @test_passage.passed? && tests_count == 1
    end
  end
end