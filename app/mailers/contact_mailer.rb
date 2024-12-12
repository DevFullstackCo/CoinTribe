class ContactMailer < ApplicationMailer
  def welcome_email(user)
    @user = user


      mail(
        to: @user.email,
        subject: "Welcome to our home !"
        )
    end

  def send_contact_email(admin_email, subject, message, user_email)
    @message = message
    @user_email = user_email
    mail(
      to: admin_email,
      subject: subject
    )
  end
end
