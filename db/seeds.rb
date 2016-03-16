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

page1 = Page.create!(id: 1, titolo: 'Home ADS', descrizione: 'Home page generale degli ADS', section: section1)
page2 = Page.create!(id: 2, titolo: 'Home SCOUT', descrizione: 'Home page generale degli SCOUT', section: section2)

Row.delete_all
row11 = Row.create!(id: 1, ordine: 1, page: page1)
row12 = Row.create!(id: 2, ordine: 2, page: page1)
row21 = Row.create!(id: 3, ordine: 1, page: page2)
row22 = Row.create!(id: 4, ordine: 2, page: page2)

Area.delete_all
area111 = Area.create!(id: 1, ordine: 1, row: row11)
area112 = Area.create!(id: 2, ordine: 2, row: row11)
area121 = Area.create!(id: 3, ordine: 1, row: row12)
area121 = Area.create!(id: 4, ordine: 2, row: row12)
area211 = Area.create!(id: 5, ordine: 1, row: row21)
area212 = Area.create!(id: 6, ordine: 2, row: row21)
area221 = Area.create!(id: 7, ordine: 1, row: row22)
area221 = Area.create!(id: 8, ordine: 2, row: row22)

