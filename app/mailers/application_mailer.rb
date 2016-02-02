class ApplicationMailer < ActionMailer::Base
  default from: "dont_reply@travbook.me"

  def reset_password_email(user, token)
    @user = user
    @url  = 'localhost:3000/resetpassword?token=' + token
    mail(to: @user.email, subject: 'Reset your password!')
  end
end
