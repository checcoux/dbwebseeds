namespace :articoli do
  require_relative "importer"

  desc "Import old database, usage: rake articoli:import['old_database_name']"
  task :import do |t, args|
    newDatabaseName = 'donboscoland'

    importer = Importer.new newDatabaseName
    importer.execute
  end
end