class QuestionsController < ApplicationController
  before_action :find_test, only: %i[new create]
  before_action :search, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render json: @test.questions
  end

  def new
    @question = @test.questions.new
  end

  def show
    render inline: '<%= @question.inspect %>'
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to @test
    else
    render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to @question.test
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
