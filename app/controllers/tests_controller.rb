class TestsController < ApplicationController
    
  before_action :find_test, only: %i[show edit update destroy start]
  before_action :find_user, only: :start
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show
    render inline: '<%= @test.inspect %>'
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(tests_params)

    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def search
  end

  def edit
  end

  def update
    if @test.update(tests_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def tests_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def find_user
    @user = User.first
  end

  def send_log_message
    logger.info("Action #{action_name} was finished")
  end

  def log_execute_time
    start = Time.now
    yield
    finish = Time.now - start
    logger.info("Execution time: #{finish * 1000} ms")
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end
