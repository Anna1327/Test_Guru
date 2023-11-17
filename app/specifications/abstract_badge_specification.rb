# frozen_string_literal: true

class AbstractBadgeSpecification
  def initialize(
    badge:,
    test_passage:
  )
    @badge = badge
    @test_passage = test_passage
  end

  def win?
    raise "Method #{__method__} undefined for #{self.class}"
  end

  private

  def level_by_name(name)
    TestsHelper::TEST_LEVELS.key(name.to_sym)
  end
end