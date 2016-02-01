class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"

  def reset_password_email(user, token)
    @user = user
    @url  = 'localhost:3000/reset?token=' + token
    mail(to: @user.email, subject: 'Reset your password!')
  end
end
