# frozen_string_literal: true

class TestsController < ApplicationController

  before_action :authenticate_user!  
  before_action :find_test, only: %i[start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all.where(published: true)
  end

  def start
    current_user.tests.push(@test)
    TestPassage.create(user_id: current_user.id, test_id: @test.id)
    redirect_to current_user.test_passage(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end
