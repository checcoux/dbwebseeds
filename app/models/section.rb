# sezione del sito

class Section < ActiveRecord::Base
  validates :titolo, :descrizione, presence: true

  has_many :pages, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many :users, dependent: :nullify
  has_many :photoalbums, dependent: :destroy

  def trova_modello
    # cerchiamo un modello
    # esiste un modello per questa sezione?
    modello = Page.find_by section: self, modello: true

    # se non esiste cerco un modello nella sezione principale
    if !modello
      sezione = trova_principale
      modello = Page.find_by section: sezione, modello: true
    end

    modello
  end

  def trova_principale
    Section.find_by principale: true
  end

  def trova_home
    Page.find_by section: self, home: true
  end
end
