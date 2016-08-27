# viene creata una sezione principale di default
section = Section.create(titolo: 'Principale', descrizione: 'Sezione principale del sito.', principale: true, percorso: '')

# viene creata una home page di default per la sezione principale
page = Page.create(titolo: 'Home page', section_id: section.id, home: true, slug: 'home-page', visibile: true)

row = Row.create(ordine: 1, page_id: page.id, estesa: false, colore_sfondo: '')

Column.create(ordine: 1, contenuto: 'Cantami o diva del pelide Achille l\'ira funesta...', row_id: row.id, larghezza: 12)

# viene creato un amministratore di default
user = User.create(email: 'admin', password: '123456', password_confirmation: '123456', admin: true)