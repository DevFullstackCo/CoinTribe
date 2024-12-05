class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    @url  = 'https://cryptovotingproject-cc7f6a61a180.herokuapp.com/' 

    mail(
      to: @user.email, 
      subject: 'Welcome to our home !'
      ) 
  end

end
