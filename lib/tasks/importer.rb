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
      SELECT * from articoli ORDER BY id LIMIT 5
      ')

    for i in 0...articoli.count do
      r = articoli.get_row i

      puts "Importazione articolo #{r.get("id")} #{r.get("titolo")}"

      # creazione di una nuova pagina
      page = Page.create(titolo: r.get('titolo'), abstract: ActionView::Helpers::SanitizeHelper.strip_tags(r.get('abstract')), section_id: 9, visibile: true, articolo: true, published_at: r.get('data'))

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