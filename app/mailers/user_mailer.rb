class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    @url  = 'https://cryptovotingproject-cc7f6a61a180.herokuapp.com/' 

    mail(
      to: @user.email, 
      subject: 'Welcome onboard !'
      )
  end

  def account_deleted_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Your account has been deleted"
    )
  end

  def price_alert_email(alert, price_crypto)
    @alert = alert
    @user = alert.user
    @crypto = alert.crypto
    @price_crypto = price_crypto
    
    mail(
      to: @user.email,
      subject: "Alert Price on #{@crypto.name}"
    )
  end

end
