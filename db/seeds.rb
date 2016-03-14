# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Section.delete_all

section1 = Section.create!(titolo: 'ADS', descrizione: 'Amici Domenico Savio')
section2 = Section.create!(titolo: 'KB', descrizione: 'Gruppo Key Boys')
Section.create!(titolo: 'GEN3', descrizione: 'Gruppo GEN3')
Section.create!(titolo: 'SCOUT', descrizione: 'Scout')
Section.create!(titolo: 'CAMELOT', descrizione: 'Clan Camelot')
Section.create!(titolo: 'WAINGUNGA', descrizione: 'Branco Waingunga')

Page.delete_all

Page.create!(id: 1, titolo: 'Home ADS', descrizione: 'Home page generale degli ADS', section: section1)
Page.create!(id: 2, titolo: 'Home SCOUT', descrizione: 'Home page generale degli SCOUT', section: section2)