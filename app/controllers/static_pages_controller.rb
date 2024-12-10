class StaticPagesController < ApplicationController
  def cgu
  end

  def privacy_policy
  end

  def send_message
    guest_email = params[:guest_email]
    subject = params[:subject]
    message = params[:message]

    user_email = current_user ? current_user.email : guest_email

    if user_email.blank?
      flash[:alert] = "Please provide your email to send a message."
      redirect_to contact_path and return
    end
  
    admin_emails = User.where(is_admin: true).pluck(:email)
  
    admin_emails.each do |admin_email|
      ContactMailer.send_contact_email(admin_email, subject, message, user_email).deliver_now
      flash[:notice] = "Your message has been sent successfully."
    end
  
    redirect_to contact_path
  end
  
end
