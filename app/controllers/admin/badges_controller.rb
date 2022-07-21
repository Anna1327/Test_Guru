require 'fileutils'

class Admin::BadgesController < Admin::BaseController
  before_action :find_badge, only: %i[ show edit update destroy ]

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
    Rails.logger.info("здесь параметры #{badge_params.inspect}")
    if params[:badge][:image]
      url = move_image_url(params[:badge][:image])
      @badge_params[:image_url] = url
      @badge_params.permit(:image_url)
      Rails.logger.info("здесь основные параметры #{@badge_params.inspect}")
    end
    if @badge.update(@badge_params)
      redirect_to admin_badges_path
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def badge_params
    @badge_params ||= params.require(:badge).permit(:title, :image_url, :condition)
  end

  def find_badge
    @badge = Badge.find(params[:id])
  end

  def move_image_url(image_url)
    image_url = image_url.tempfile.path.to_s
    path_to_file = "app/assets/images/badge#{Random.new.rand(1_000_000)}.png"
    FileUtils.mv(image_url, path_to_file)
    path_to_file
  end
end
