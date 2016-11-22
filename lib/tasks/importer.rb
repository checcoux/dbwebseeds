class Importer
  def initialize new
    puts "Importing on #{new}"
  end

  def execute
    import_articoli
  end

  def import_articoli
    puts "Importing articles..."

    articoli = ActiveRecord::Base.connection.execute('
      SELECT * from articoli ORDER BY id LIMIT 5 OFFSET 100
      ')

    for i in 0...articoli.count do
      r = articoli.get_row i
      anno = r.get('data').year
      titolo = ActionController::Base.helpers.strip_tags(r.get('titolo'))
      abstract = ActionController::Base.helpers.strip_tags(r.get('abstract'))
      solo_testo = ActionController::Base.helpers.sanitize(r.get('testo'), tags: %w(p strong em a b i), attributes: %w(href) )
      testo = "<p><img src='/img/copertine/articoli_#{anno}.jpg' style='width: 100%;'></p><h1>#{titolo}</h1><h2>da #{r.get('old_testata')}</h2>#{solo_testo}"
      # verificare se ci sono altri tag da salvare
      # vanno poi aggiunti autore e link
      # infine va aggiunta l'immagine preparata da Jaime

      puts "Importazione articolo #{r.get('id')} #{titolo}"

      # creazione di una nuova pagina
      page = Page.create(titolo: titolo, abstract: abstract, section_id: 9, visibile: true, articolo: true, published_at: r.get('data'))

      row = Row.create(ordine: 1, page_id: page.id, estesa: false, colore_sfondo: '#ffffff')

      Column.create(ordine: 1, contenuto: testo, row_id: row.id, larghezza: 12)

    end
  end
end

# custom mysql row to facilite access
class Riga
  def initialize fields, values
    @fields = fields
    @values = values
  end

  def get field
    @values[@fields.index(field)]
  end
end

# Add get_row method to Mysql2::Result class
class Mysql2::Result
  def get_row index
    Riga.new self.fields, self.to_a[index].to_a
  end
end