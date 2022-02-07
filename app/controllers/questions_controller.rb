class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create]
  before_action :search, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render json: @test.questions
  end

  def new
  end

  def show
    render inline: '<%= @question.inspect %>'
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
    redirect_to test_questions_url(@question.test_id)
    else
    render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_url(@question.test_id)
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
