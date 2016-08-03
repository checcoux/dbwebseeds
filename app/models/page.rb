class Page < ActiveRecord::Base
  extend FriendlyId
  belongs_to :section
  has_many :rows, dependent: :destroy

  friendly_id :slug_candidates, :use => :slugged
  validates_presence_of :titolo, :slug

  def slug_candidates
    [
        [ section.percorso, :titolo ]
    ]
  end

  def trova_header
    # cerchiamo un header
    # esiste un header per questa sezione?
    intestazione = Page.find_by section: section, header: true

    # se non esiste cerco un header nella sezione principale
    if !intestazione
      sezione = Section.find_by principale: true
      intestazione = Page.find_by section: sezione, header: true
    end

    intestazione
  end

  def trova_footer
    # cerchiamo un footer
    # esiste un footer per questa sezione?
    piedipagina = Page.find_by section: section, footer: true

    # se non esiste cerco un footer nella sezione principale
    if !piedipagina
      sezione = Section.find_by principale: true
      piedipagina = Page.find_by section: sezione, footer: true
    end

    piedipagina
  end

  self.per_page = 15
end
