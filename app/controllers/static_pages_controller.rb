class StaticPagesController < ApplicationController
  def cgu
  end

  def privacy_policy
  end

  def send_message
    subject = params[:subject]
    message = params[:message]
  
    admin_emails = User.where(is_admin: true).pluck(:email)
  
    if admin_emails.any?
      admin_emails.each do |admin_email|
        ContactMailer.send_contact_email(admin_email, subject, message, current_user.email).deliver_now
      end
      flash[:notice] = "Votre message a été envoyé avec succès."
    else
      flash[:alert] = "Aucun administrateur n'est disponible pour recevoir votre message."
    end
  
    redirect_to contact_path
  end
  
end
