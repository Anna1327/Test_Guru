class Admin
  class BaseController < ApplicationController

    layout 'admin'

    before_action :authenticate_user!
    before_action :admin_required!

    private

    def admin_required!
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorized to view this page' 
      end
    end
  end
end 