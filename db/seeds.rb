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

page1 = Page.create!(id: 1, titolo: 'Home ADS', section: section1)
page2 = Page.create!(id: 2, titolo: 'Home SCOUT', section: section2)

Row.delete_all
row11 = Row.create!(id: 1, ordine: 2, page: page1)
row12 = Row.create!(id: 2, ordine: 3, page: page1)
row21 = Row.create!(id: 3, ordine: 1, page: page2)
row22 = Row.create!(id: 4, ordine: 2, page: page2)
row0 = Row.create!(id: 5, ordine: 1, page: page1)

Area.delete_all
Area.create!(id: 1, ordine: 2, row: row11, larghezza: 6, contenuto: '<h2>Prova prova prova prova</h2>')
Area.create!(id: 2, ordine: 1, row: row11, larghezza: 6, contenuto: '<a href=''><h2>Prova prova prova prova</h2></a><p>jkd sdfjk dasjljdsalòf </p>')
Area.create!(id: 3, ordine: 1, row: row12, larghezza: 4, contenuto: '<h3>Hello 121</h3><p>hkjsdf hjksdfhjk sdf</p>')
Area.create!(id: 4, ordine: 2, row: row12, larghezza: 8, contenuto: '<h3>Hello</h3><p>fhj s  sdfjf dskjlaos </p>')
Area.create!(id: 9, ordine: 1, row: row0, larghezza: 12, contenuto: '<h1>Mega titolone</h1>')

Area.create!(id: 5, ordine: 1, row: row21, larghezza: 8, contenuto: 'Hello')
Area.create!(id: 6, ordine: 2, row: row21, larghezza: 4, contenuto: 'Hello')
Area.create!(id: 7, ordine: 1, row: row22, larghezza: 3, contenuto: 'Hello')
Area.create!(id: 8, ordine: 2, row: row22, larghezza: 9, contenuto: 'Hello')



