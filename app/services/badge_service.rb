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
    else
      create_new_completed_test(passed)
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

  def create_new_completed_test(passed)
    completed_test = CompletedTest.new(user_id: @user_id, test_id: @test_id, passed: passed)
    completed_test.save!
    if completed_test.attempts == 1
      check_first_attempt_badge
    end
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

  def check_conditions(badge)
    if badge.condition["level"]
      level = badge.condition["level"]
      all_test_ids = find_all_tests_by_level(level)
      completed_test_ids = get_completed_test_level_ids(level)
      add_badge_to_user(all_test_ids, completed_test_ids, badge)
    elsif badge.condition["category"]
      category = badge.condition["category"]
      all_test_ids = find_all_tests_by_category(category)
      completed_test_ids = get_completed_test_category_ids(category)
      add_badge_to_user(all_test_ids, completed_test_ids, badge)
    end
  end

  def get_completed_test_level_ids(level)
    completed_test_ids = []
    @user_completed_tests.each do |test| 
      completed_test_ids.push(test.test.id) if test.test.level == level
    end
    completed_test_ids
  end
    
  def get_completed_test_category_ids(category)
    completed_test_ids = []
    @user_completed_tests.each do |test| 
      completed_test_ids.push(test.test.id) if test.test.category_id == category
    end
    completed_test_ids
  end

  def add_badge_to_user(all_test_ids, completed_test_ids, badge)
    completed_test_ids = completed_test_ids.sort
    if completed_test_ids == all_test_ids && !completed_test_ids.empty? && !all_test_ids.empty?
      current_badge = UserBadge.where(user_id: @test_passage.user.id, badge_id: badge.id)
      unless current_badge.presence
        new_badge = @test_passage.user.user_badges.new(badge_id: badge.id)
        new_badge.save
      end
    end
  end
end