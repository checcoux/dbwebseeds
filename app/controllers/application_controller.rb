class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Pundit cura l'autorizzazione degli utenti
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def trova_sezione_principale
    Section.find_by(principale: true)
  end

  def trova_home
    trova_sezione_principale.trova_home
  end

  private

  def user_not_authorized
    flash[:alert] = "Non autorizzato."
    redirect_to(request.referrer || '/' )
  end
end
