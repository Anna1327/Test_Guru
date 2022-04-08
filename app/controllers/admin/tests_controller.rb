# frozen_string_literal: true

class Admin
  class TestsController < Admin::BaseController
    before_action :find_tests, only: %i[index update_inline]
    before_action :find_test, only: %i[show edit update destroy update_inline]

    rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

    def index
    end

    def show
    end

    def new
      @test = Test.new
    end

    def create
      @test = current_user.created_tests.new(tests_params)
      begin
        if @test.save
          redirect_to [:admin, @test], notice: t('.success')
        else
          render :new
        end
      rescue StandardError
        redirect_to new_admin_test_path, notice: t('.failure')
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

    def update_inline
      if @test.update(tests_params)
        redirect_to admin_test_path(@test)
      else
        render :index
      end
    end

    def destroy
      @test.destroy
      redirect_to admin_tests_path
    end

    private

    def tests_params
      params.require(:test).permit(:title, :level, :category_id, :published)
    end

    def find_tests
      @tests = Test.all
    end

    def find_test
      @test = Test.find(params[:id])
    end

    def rescue_with_test_not_found
      render plain: 'Test was not found'
    end
  end
end