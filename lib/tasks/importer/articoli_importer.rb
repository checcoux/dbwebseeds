module UsersImporter

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