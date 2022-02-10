# frozen_string_literal: true

class Admin
  class TestsController < Admin::BaseController

    before_action :find_test, only: %i[show edit update destroy]

    rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

    def index
      @tests = Test.all
    end

    def show
    end

    def new
      @test = Test.new
    end

    def create
      @test = Test.new(tests_params)
      @test.author_id = current_user.id

      if @test.save
        redirect_to admin_test_path(@test)
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
        redirect_to admin_test_path(@test)
      else
        render :edit
      end
    end

    def destroy
      @test.destroy
      redirect_to admin_tests_path
    end

    private

    def tests_params
      params.require(:test).permit(:title, :level, :category_id)
    end

    def find_test
      @test = Test.find(params[:id])
    end

    def rescue_with_test_not_found
      render plain: 'Test was not found'
    end
  end
end