# frozen_string_literal: true

class Admin
  class QuestionsController < Admin::BaseController

    before_action :find_test, only: %i[new create]
    before_action :search, only: %i[show edit update destroy]

    rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

    def new
      @question = @test.questions.new
    end

    def show
    end

    def create
      @question = @test.questions.new(question_params)
      if @question.save
        @question.update(number: @test.questions.count)
        redirect_to admin_test_path(@test)
      else
        render :new
      end
    end

    def update
      if @question.update(question_params)
        redirect_to admin_question_path(@question)
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      redirect_to admin_test_path(@question.test)
    end

    private

    def question_params
      params.require(:question).permit(:body)
    end

    def search
      @question = Question.find(params[:id])
    end

    def find_test
      @test = Test.find(params[:test_id])
    end

    def rescue_with_question_not_found
      render plain: 'Not found'
    end
  end
end