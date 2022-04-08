class ContactUsMailer < ActionMailer::Base
  layout false
  default from: ENV['SMTP_USERNAME']
  def send_mail
    mail(to: ENV['SMTP_ADMIN_EMAIL'], subject: 'New Question from User!',
      body: "<html><body>        
      <p>Name: #{params[:name]}</p>
      <p>Email: #{params[:email]}</p>
      <p>Question: #{params[:question]}</p>
      </body></html>",
    content_type: 'text/html')
  end
end 