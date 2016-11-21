namespace :articoli do
  require_relative "importer"

  desc "Import old database, usage: rake articoli:import RAILS_ENV='production'"
  task :import => :environment do
    newDatabaseName = 'donboscoland'

    importer = Importer.new newDatabaseName
    importer.execute
  end
end