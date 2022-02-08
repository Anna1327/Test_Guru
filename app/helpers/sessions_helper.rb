# frozen_string_literal: true

module SessionsHelper
  def flash_alert
    if flash[:alert] 
        content_tag :p, flash[:alert], class: 'flash alert'
    end
  end
end
