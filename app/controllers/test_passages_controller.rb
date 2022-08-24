# frozen_string_literal: true

class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]
  before_action :check_time_left, only: %i[show update gist]

  def show
  end

  def result
  end

  def update
    if params[:answer_ids]
      @test_passage.accept!(params[:answer_ids])

      if @test_passage.completed?
        TestsMailer.completed_test(@test_passage).deliver_now
        redirect_to result_test_passage_path(@test_passage)
      else
        render :show
      end
    else
      redirect_to test_passage_path, notice: t('.no_answer')
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    result = service.call
    if service.success?
      current_user.gists.create(
        url: result.html_url, 
        question_id: @test_passage.current_question.id, 
        author_id: current_user.id)

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

  def check_time_left
    redirect_to result_test_passage_path(@test_passage) if time_left?
  end

  def time_left?
    @test_passage.created_at + @test_passage.test.timer * 60 - Time.now <= 0 ? true : false
  end
end
