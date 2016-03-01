# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Layout.delete_all

layout1 = Layout.create!(titolo: 'Layout 1')
layout2 = Layout.create!(titolo: 'Layout 2')

Section.delete_all

Section.create!(titolo: 'ADS', descrizione: 'Amici Domenico Savio')
Section.create!(titolo: 'KB', descrizione: 'Gruppo Key Boys')
Section.create!(titolo: 'GEN3', descrizione: 'Gruppo GEN3')
Section.create!(titolo: 'SCOUT', descrizione: 'Scout')
Section.create!(titolo: 'CAMELOT', descrizione: 'Clan Camelot')
Section.create!(titolo: 'WAINGUNGA', descrizione: 'Branco Waingunga')

Page.delete_all

Page.create!(id: 1, titolo: 'Home ADS', descrizione: 'Home page generale degli ADS', layout: layout1)
Page.create!(id: 2, titolo: 'Home SCOUT', descrizione: 'Home page generale degli SCOUT', layout: layout2)