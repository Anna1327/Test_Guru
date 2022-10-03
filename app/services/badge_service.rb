class BadgeService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
    @badges = Badge.all
    @user_completed_tests = TestPassage.where(user_id: @user.id, passed: true)
  end
  
  def check_completed_test
    if @user_completed_tests.presence
      check_badges
    end
  end

  def check_badges
    @badges.each do |badge|
      check_conditions(badge)
    end
  end

  private

  def check_attempts
    @user_completed_tests.where(test_id: @test.id).count
  end

  def current_badge
    UserBadge.where(user_id: @user, badge_id: badge.id)
  end

  def check_first_attempt_badge(badge)
    if check_attempts == 1 && current_badge.blank?
      new_badge = @test_passage.user.user_badges.new(badge_id: badge.id)
      new_badge.save
    end
  end

  def check_conditions(badge)
    condition = JSON.parse badge.condition.gsub('=>', ':')
    if key == "first_try"
      check_first_attempt_badge(badge)
    else
      tests_for_badge = Test.where(condition.keys[0].to_s => condition.values[0].to_s).pluck(:id)
      add_badge_to_user(tests_for_badge, @user_completed_tests.pluck(:test_id), badge)
    end
  end

  def add_badge_to_user(tests_for_badge, user_tests, badge)
    if ((tests_for_badge - user_tests.uniq).empty? || tests_for_badge == user_tests.uniq) && current_badge.empty?
      new_badge = @test_passage.user.user_badges.new(badge_id: badge.id)
      new_badge.save
    end
  end
end