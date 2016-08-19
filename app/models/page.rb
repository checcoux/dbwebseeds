class Page < ActiveRecord::Base
  after_initialize do |page|
    @colonne_selezionate = []
  end

  extend FriendlyId
  belongs_to :section
  has_many :rows, dependent: :destroy
  has_many :columns, dependent: :destroy

  friendly_id :slug_candidates, :use => :slugged
  validates_presence_of :titolo, :slug

  def slug_candidates
    [
        [section.percorso, :titolo]
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

  def dinamiche(fonte = 1)
    case fonte
      when 1 # colonne della stessa pagina
        Column.where("page_id = ? AND row_id = 0", id)
      when 2..3 # colonne della stessa sezione (todo: stesso parent)
        Column.joins(:page).where(:row_id => 0, :pages => {:section_id => section})
      when 4..6 # tutto il sito (todo: siti affini e intero cloud)
        Column.where("row_id = 0")
    end
  end

  def candidata(fonte = 1)
    dinamiche(fonte).order('created_at DESC').each do |colonna|
      if !@colonne_selezionate.include?(colonna.id)
        @colonne_selezionate << colonna.id
        return colonna
        break
      end
    end
    nil
  end

  self.per_page = 15
end
