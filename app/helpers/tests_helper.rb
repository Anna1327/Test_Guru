module TestsHelper
  TEST_LEVELS = { (0..2) => :easy, (2..4) => :middle, (5..) => :hard }.freeze

  def test_level(test)
    TEST_LEVELS.detect { |level, _| level.include?(test.level) }.last
  end
end
