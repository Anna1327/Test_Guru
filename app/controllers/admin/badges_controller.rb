# frozen_string_literal: true

require 'fileutils'

class Admin
  class BadgesController < Admin::BaseController
    before_action :find_badge, only: %i[show edit update destroy]
    before_action :dataset, only: %i[new create]

    def index
      @badges = Badge.all
      @user_badges = current_user.badges
    end

    def show
    end

    def new
      @badge = Badge.new
    end

    def edit
    end

    def create
      @badge = Badge.new(badge_params)

      if @badge.save
        redirect_to admin_badge_url(@badge), notice: t('.success')
      else
        render :new
      end
    end

    def update
      if @badge.update(badge_params)
        redirect_to admin_badges_path
      else
        render :edit
      end
    end

    def destroy
      @badge.destroy!

      redirect_to admin_badges_path
    end

    private

    def badge_params
      @badge_params ||= params.require(:badge).permit(:title, :image_url, :condition)
    end

    def find_badge
      @badge = Badge.find(params[:id])
    end

    def dataset
      @condition = {
        'category_id' => Category.all.pluck(:id, :title),
        'level' => TestsHelper::TEST_LEVELS.values.map { |val| [val, val] },
        'first_try' => []
      }
    end
  end
end
