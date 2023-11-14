# frozen_string_literal: true

class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]

  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed? || check_time_left
      @test_passage.update!(passed: true) if @test_passage.passed?
      badges = BadgeService.new(@test_passage).check_completed_test
      win_badges_flash(badges.pluck(:title)) unless badges.nil?

      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    result = service.call
    if service.success?
      current_user.gists.create(
        url: result.html_url,
        question_id: @test_passage.current_question.id,
        author_id: current_user.id
      )

      flash_options = { notice: t('.success') }
    else
      flash_options = { notice: t('.failure') }
    end
    redirect_to @test_passage, flash_options
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def win_badges_flash(badges)
    flash[:success] = "#{t('test_passages.result.badge_win')}: #{badges.join(',')}!" unless badges.count.zero?
  end

  def check_time_left
    redirect_to result_test_passage_path(@test_passage) if time_left?
  end

  def time_left?
    @test_passage.get_timer <= 0
  end
end