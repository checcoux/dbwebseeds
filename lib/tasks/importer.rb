class Importer
  # initializer for a new importer
  def initialize new
    # feedback for the programmer
    puts "Importing on #{new}"

    @newDb = new
  end

  # execute the import
  def execute

    # if you do not like to import data, if the new database
    # already contains data, just a security hint..
    #if User.count > 0
    #  raise "Import aborted! There already are users in the database."
    #end

    # call sub-importer modules
    import_articoli
  end

  # later in the import process you have to switch between
  # the old and the new database.

  # use new database (= switch to new database)
  def use_new_database
    # ActiveRecord::Base.connection.execute("use #{@newDb}")
    ActiveRecord::Base.establish_connection(
        adapter: 'mysql2',
        encoding: 'utf8',
        reconnect: false,
        database: 'donboscoland',
        pool: 5,
        username: 'root',
        password: 'password2',
        host: 'localhost'
    )

  end

  # import articoli
  def import_articoli
    puts "Importing articles..."
    use_new_database
    articoli = ActiveRecord::Base.connection.execute('
      SELECT * from articoli LIMIT 10 order by id
      ')

    for i in 0...articoli.count do
      row = articoli.get_row i

      # user = User.new(first_name: row.get("firstname"),
      # last_name: row.get("lastname"),
      # email: row.get("mail"),
      # isfemale: row.get("isfemale"))
      begin
        # user.save!
        puts "Importazione articolo #{row.get("id")} #{row.get("titolo")}"
      rescue Exception => e
        # puts "Failed to save #{row.get("firstname")} #{row.get("lastname"): #{e.message}"
      end
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