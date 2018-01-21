class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # Prova da Cloud9
  protect_from_forgery with: :exception

  # Pundit cura l'autorizzazione degli utenti
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # redirect dopo il sign_in di Devise
  #def after_sign_in_path_for(user)
  #  if current_user.aggiornato
  #    '/'
  #  else
  #    '/edit-profile'
  #  end
  #end

  def trova_sezione_principale
    Section.find_by(principale: true)
  end
  helper_method :trova_sezione_principale

  def trova_home
    trova_sezione_principale.trova_home
  end
  helper_method :trova_home

  private

  def user_not_authorized
    flash[:alert] = "Non autorizzato."
    redirect_to(request.referrer || '/' )
  end
end
