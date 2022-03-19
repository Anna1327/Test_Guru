class ContactUsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
  def index
  end
  
  def create
    ContactUsMailer.with(contact_us_params).send_mail.deliver_later
    redirect_to :root
  end
  
  private
  
  def contact_us_params
    params.permit(:name, :email, :question)
  end
end 
