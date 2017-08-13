class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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

  def trova_home
    trova_sezione_principale.trova_home
  end

  def trova_profilo
    # attenzione: un'entity di tipo profilo deve essere definita

    entity = Entity.find_by! slug: 'profilo'

    profilo = Instance.find_by entity_id: entity.id, user_id: current_user.id

    if profilo
      # restituisce il profilo
      profilo
    else
      # crea un nuovo profilo vuoto
      profilo = Instance.create entity_id: entity.id, user_id: current_user.id, section_id: trova_sezione_principale.id
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "Non autorizzato."
    redirect_to(request.referrer || '/' )
  end
end
