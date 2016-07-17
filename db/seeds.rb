section = Section.create(titolo: 'HOME', descrizione: 'Sezione principale del sito.')

page = Page.create(titolo: 'Home page', section_id: section.id)

row = Row.create(ordine: 1, page_id: page.id, estesa: false, colore_sfondo: '')

column = Column.create(ordine: 1, contenuto: 'Cantami o diva del pelide Achille l\'ira funesta...', row_id: row.id, larghezza: 12)
