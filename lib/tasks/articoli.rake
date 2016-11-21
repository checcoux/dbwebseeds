namespace :articoli do
  require "importer"

  desc "Import old database, usage: rake articoli:import['old_database_name']"
  task :import, :oldDatabase, needs::environment do |t, args|
    args.with_defaults(oldDatabase: "import")

    newDatabaseName = YAML::load(IO.read(Rails.root.join("config/database.yml")))[Rails.env]["database"]

    importer = Importer.new newDatabaseName, oldDatabaseName
    importer.execute
  end
end