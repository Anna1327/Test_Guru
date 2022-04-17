class BadgeService

  def initialize(test_passage)
    @test_passage = test_passage
    @user_id = @test_passage.user.id
    @test_id = @test_passage.test.id
    @badges = Badge.all
    @user_completed_tests = CompletedTest.where(user_id: @user_id, passed: true)
  end
  
  def create_completed_test(passed)
    completed_test = CompletedTest.where(user_id: @user_id, test_id: @test_id)
    if completed_test.presence
      update_completed_test(completed_test, passed)
    end
  end

  def check_badges
    @badges.each do |badge|
      check_conditions(badge)
    end
  end

  private

  def update_completed_test(completed_test, passed)
    completed_test.first.update(passed: passed, attempts: completed_test.first.attempts + 1)
  end

  def check_first_attempt_badge
    badge_id = Badge.find_by(title: "First Try Tests").id
    new_badge = @test_passage.user.user_badges.new(badge_id: badge_id)
    new_badge.save!
  end

  def find_all_tests_by_level(level)
    test_ids = []
    tests = Test.where(level: level)
    tests.each do |test|
      test_ids.push(test.id)
    end
    test_ids.sort
  end
    
  def find_all_tests_by_category(category)
    test_ids = []
    tests = Test.where(category_id: category)
    tests.each do |test|
      test_ids.push(test.id)
    end
    test_ids.sort
  end

  def check_conditions(badge, user)
    if badge.condition["level"]
      level = badge.condition["level"]
      tests_for_badge = Test.where(level: level)
    elsif badge.condition["category"]
      category = badge.condition["category"]
      tests_for_badge = Test.where(category: category).pluck(:id)
    end
    user_tests = TestPassage.find_by(user_id: user.id).pluck(:test_id)
    add_badge_to_user(tests_for_badge, user_tests, badge)
  end

  def add_badge_to_user(tests_for_badge, user_tests, badge)
    user_tests = user_tests.sort
    if user_tests == tests_for_badge && !user_tests.empty? && !tests_for_badge.empty?
      current_badge = UserBadge.where(user_id: @test_passage.user.id, badge_id: badge.id)
      unless current_badge.presence
        new_badge = @test_passage.user.user_badges.new(badge_id: badge.id)
        new_badge.save
      end
    end
  end
end