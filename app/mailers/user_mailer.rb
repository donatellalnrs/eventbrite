class UserMailer < ApplicationMailer
  default from: 'contact@eventbrite.fr'
 
  def welcome_email(user)
    @user = user 
    @url  = 'https://eventbritedona.herokuapp.com/' 
    mail(to: @user.email, subject: 'Bienvenue chez Eventbrite !') 
  end

  def attendance_email(user, event)
    @user = user 
    @event = event
    @url  = 'https://eventbritedona.herokuapp.com/' 
    mail(to: @user.email, subject: 'Confirmation de votre participation à un événement Eventbrite !') 
  end
end
