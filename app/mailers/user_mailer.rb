class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    @url  = 'https://cryptovotingproject-cc7f6a61a180.herokuapp.com/' 

    mail(
      to: @user.email, 
      subject: 'Welcome to our home !'
      ) 
  end

  def account_deleted_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Your account has been deleted"
    )
  end

end
