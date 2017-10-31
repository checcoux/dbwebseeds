admin = User.new([
  {email: "test@donboscoland.it", password: 'testtest', password_confirmation: 'testtest', reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 38, current_sign_in_at: "2017-10-31 15:57:43", last_sign_in_at: "2017-10-31 15:56:03", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", confirmation_token: "wRtgCygEnxpZcoiYjF1x", confirmed_at: "2016-07-24 13:41:08", confirmation_sent_at: "2017-06-25 13:25:48", unconfirmed_email: nil, admin: true, section_id: nil, designer: false, aggiornato: true},
])
admin.skip_confirmation!
admin.save!

Column.create!([
  {ordine: 1, contenuto: "<ul class=\"vertical medium-horizontal menu\">\n\t<li><a class=\"secondary button\" href=\"/\">Home</a></li>\n\t<li><a class=\"warning button\" href=\"/login\">Login</a></li>\n\t<li><a class=\"secondary button\" href=\"/sezione1\">sezione 1</a></li>\n\t<li><a class=\"secondary button\" href=\"/storia\">La nostra storia</a></li>\n\t<li><a class=\"secondary button\" href=\"/oratorio\">Oratorio</a></li>\n\t<li><a class=\"secondary button\" href=\"http://www.donboscosandona.it\">Scuola</a></li>\n\t<li><a class=\"secondary button\" href=\"/cinema\">Cinema</a></li>\n\t<li><a class=\"secondary button\" href=\"/contatti\">Contatti</a></li>\n\t<li><a class=\"warning button\" href=\"/logout\">Logout</a></li>\n</ul>\n", row_id: 352, larghezza: 12, fonte: 0, page_id: 0, autocrop: false, padding: "0em", condivisa: true},
  {ordine: 1, contenuto: "<h1>Titolo</h1>\n\n<p><span class=\"abstract\">Abstract</span></p>\n\n<p>Testo...</p>\n\n<p>&nbsp;</p>\n", row_id: 359, larghezza: 12, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 1, contenuto: "<p>Contenuto della colonna 3a.</p>\n\n<p class=\"testo_piccolo\">&nbsp;</p>\n", row_id: 372, larghezza: 8, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 4, contenuto: "<p>Contenuto della colonna 2d.</p>\n\n<p class=\"testo_piccolo\">Testo piccolo.</p>\n", row_id: 373, larghezza: 3, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 2, contenuto: "<p>Contenuto della colonna 3b.</p>\n", row_id: 372, larghezza: 4, fonte: 4, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 1, contenuto: "<p>Contenuto della colonna 2a.</p>\n", row_id: 373, larghezza: 3, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 3, contenuto: "<p>Contenuto della colonna 2c.</p>\n", row_id: 373, larghezza: 3, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 1, contenuto: "<p>&laquo;&nbsp;A nove anni ho fatto un sogno. Mi pareva di essere vicino a casa, in un cortile molto vasto, dove si divertiva una gran quantit&agrave; di ragazzi. Alcuni ridevano, altri giocavano, non pochi bestemmiavano. Al sentire le bestemmie mi slanciai in mezzo a loro. Cercai di farli tacere usando pugni e parole.</p>\n\n<p>In quel momento apparve un uomo maestoso, vestito nobilmente. Un manto bianco gli copriva tutta la persona. La sua faccia era cos&igrave; luminosa che non riuscivo a fissarla. Egli mi chiam&ograve; per nome e mi ordin&ograve; di mettermi a capo di quei ragazzi. Aggiunse: &laquo;Dovrai farteli amici non con le percosse, ma con la mansuetudine e la carit&agrave;. Su, parla, spiegagli che il peccato &egrave; una cosa cattiva e che l&#39;amicizia con il Signore &egrave; un bene prezioso&raquo;. Confuso e spaventato risposi che io ero un ragazzo povero e ignorante, che non ero capace di parlare di religione a quei monelli.</p>\n\n<p>In quel momento i ragazzi cessarono le risse, gli schiamazzi e le bestemmie e si raccolsero tutti intorno a colui che parlava. Quasi senza sapere cosa facessi gli domandai: &laquo;Chi siete voi, che mi comandate cose impossibili?&raquo; &laquo;Proprio perch&eacute; queste cose ti sembrano impossibili &ndash; rispose &ndash; dovrai renderle possibili con l&#39;obbedienza e acquistando la scienza&raquo;. &laquo;Come potr&ograve; acquistare la scienza?&raquo;. &laquo;Io ti dar&ograve; la maestra. Sotto la sua guida si diventa sapienti, ma senza di lei anche chi &egrave; sapiente diventa un povero ignorante&raquo;. &laquo;Ma chi siete voi?&raquo;. &laquo;Io sono il figlio di colei che tua madre ti insegn&ograve; a salutare tre volte al giorno&raquo;. &laquo;La mamma mi dice sempre di non stare con quelli che non conosco, senza il suo permesso. Perci&ograve; ditemi il vostro nome&raquo;. &laquo;Il mio nome domandalo a mia madre&raquo;.</p>\n", row_id: 378, larghezza: 12, fonte: 0, page_id: 0, autocrop: true, padding: "0em", condivisa: true},
  {ordine: 2, contenuto: "<p>Contenuto della colonna 2b.</p>\n", row_id: 373, larghezza: 3, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 1, contenuto: "<p><span style=\"color:#ffffff;\">Footer della pagina<br />\nIndirizzo<br />\nTelefono<br />\nSito web</span></p>\n", row_id: 383, larghezza: 12, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 1, contenuto: "<p>Home page della sezione 1.</p>\n", row_id: 384, larghezza: 12, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 1, contenuto: "<ul class=\"vertical medium-horizontal dropdown menu\" data-dropdown-menu=\"jnk7lb-dropdown-menu\" data-is-click=\"false\" role=\"menubar\">\n\t<li role=\"menuitem\"><a href=\"http://fff\">ADS</a></li>\n\t<li aria-haspopup=\"true\" aria-label=\"SCOUT\" class=\"is-dropdown-submenu-parent opens-inner opens-right\" data-is-click=\"false\" role=\"menuitem\"><a href=\"#\">SCOUT</a>\n\t<ul class=\"menu submenu is-dropdown-submenu first-sub vertical\" data-submenu=\"\" role=\"menu\" style=\"\">\n\t\t<li class=\"is-submenu-item is-dropdown-submenu-item\" role=\"menuitem\"><a href=\"http://ffff\">Lupetti</a></li>\n\t\t<li aria-haspopup=\"true\" aria-label=\"Coccinelle\" class=\"is-dropdown-submenu-parent is-submenu-item is-dropdown-submenu-item opens-right\" data-is-click=\"false\" role=\"menuitem\"><a href=\"http://ffff\">Coccinelle</a>\n\t\t<ul class=\"menu submenu is-dropdown-submenu vertical\" data-submenu=\"\" role=\"menu\" style=\"\">\n\t\t\t<li class=\"is-submenu-item is-dropdown-submenu-item\" role=\"menuitem\"><a href=\"http://ffff\">Amichette</a></li>\n\t\t\t<li class=\"is-submenu-item is-dropdown-submenu-item\" role=\"menuitem\"><a href=\"http://fffff\">Amicone</a></li>\n\t\t</ul>\n\t\t</li>\n\t</ul>\n\t</li>\n\t<li role=\"menuitem\"><a href=\"http://ffedsad\">CFP</a></li>\n</ul>\n", row_id: 395, larghezza: 12, fonte: 0, page_id: 0, autocrop: true, padding: "0em", condivisa: true},
  {ordine: 1, contenuto: "<h1>Profilo aggiornato</h1>\n\n<p>I tuoi dati sono stati aggiornati: grazie!</p>\n\n<p><a href=\"/\">Clicca qui per tornare alla home page</a>.</p>\n", row_id: 396, larghezza: 12, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true},
  {ordine: 1, contenuto: "<p><span style=\"color:#ffffff;\">dati per il primo accesso:<br />\nuser: <strong>test@donboscoland.it</strong><br />\npassword: <strong>testtest</strong></span></p>\n", row_id: 397, larghezza: 12, fonte: 0, page_id: 0, autocrop: true, padding: "", condivisa: true}
])
Datum.create!([
  {instance_id: 24, property_id: 21, valore: ": NUOVA REALTÀ :"},
  {instance_id: 25, property_id: 21, valore: "SAN DONÀ DI PIAVE (VE)"},
  {instance_id: 26, property_id: 21, valore: "MOGLIANO (TV) - ORATORIO"},
  {instance_id: 27, property_id: 21, valore: "VENEZIA CASTELLO (VE)"},
  {instance_id: 28, property_id: 21, valore: "PATANÈ (VI)"},
  {instance_id: 30, property_id: 21, valore: "CEGGIA (VE)"},
  {instance_id: 33, property_id: 21, valore: "CESENA"},
  {instance_id: 34, property_id: 21, valore: "VICENZA"},
  {instance_id: 35, property_id: 21, valore: "COMO"},
  {instance_id: 36, property_id: 21, valore: "SASSOFERRATO"},
  {instance_id: 37, property_id: 21, valore: "PADOVA"},
  {instance_id: 38, property_id: 21, valore: "CAORLE"},
  {instance_id: 39, property_id: 21, valore: "DOLO"},
  {instance_id: 40, property_id: 21, valore: "MIRANO"},
  {instance_id: 41, property_id: 21, valore: "ODERZO"},
  {instance_id: 42, property_id: 21, valore: "PRIVIERO"},
  {instance_id: 43, property_id: 21, valore: "VERONA"},
  {instance_id: 44, property_id: 21, valore: "SASSARI"},
  {instance_id: 45, property_id: 21, valore: "FORLÌ"},
  {instance_id: 46, property_id: 21, valore: "PORTO SANTA MARGHERITA"},
  {instance_id: 47, property_id: 21, valore: "TRENTO"},
  {instance_id: 49, property_id: 21, valore: "ARQUÀ PETRARCA"},
  {instance_id: 50, property_id: 22, valore: "DALL'AMMINISTRATORE"},
  {instance_id: 50, property_id: 23, valore: "CREATO"},
  {instance_id: 50, property_id: 24, valore: "m"},
  {instance_id: 51, property_id: 22, valore: "MONTAGNER"},
  {instance_id: 51, property_id: 23, valore: "FEDERICO"},
  {instance_id: 51, property_id: 24, valore: "m"},
  {instance_id: 52, property_id: 22, valore: "ROS"},
  {instance_id: 52, property_id: 23, valore: "ANDREA"},
  {instance_id: 52, property_id: 24, valore: "m"},
  {instance_id: 53, property_id: 22, valore: "ALIPRANDI"},
  {instance_id: 53, property_id: 23, valore: "CESCA"},
  {instance_id: 53, property_id: 24, valore: "m"},
  {instance_id: 54, property_id: 1, valore: "ROS"},
  {instance_id: 54, property_id: 2, valore: "ANDREA"},
  {instance_id: 54, property_id: 13, valore: "31/08/1975"},
  {instance_id: 54, property_id: 14, valore: "m"},
  {instance_id: 54, property_id: 15, valore: "0421 338911"},
  {instance_id: 54, property_id: 16, valore: "ODERZO (TV)"},
  {instance_id: 54, property_id: 17, valore: "sdb"},
  {instance_id: 54, property_id: 18, valore: "1"},
  {instance_id: 54, property_id: 19, valore: "25"},
  {instance_id: 54, property_id: 20, valore: ""}
])
Entity.create!([
  {titolo: "Profilo utente", nativo: true, slug: "profilo", user_id: 8, landing_page: "/profile-updated", riservata: false, plurale: "Profili utente"},
  {titolo: "Appartenenza", nativo: true, slug: "appartenenza", user_id: 8, landing_page: "/instances?type=appartenenza", riservata: true, plurale: "Appartenenze"},
  {titolo: "Iscrizione Meeting 2017", nativo: false, slug: "iscrizione-meeting-2017", user_id: 8, landing_page: "/", riservata: false, plurale: "Iscrizioni Meeting 2017"},
  {titolo: "Persona", nativo: false, slug: "persona", user_id: 8, landing_page: "/instances?type=persona", riservata: false, plurale: "Persone"}
])
Instance.create!([
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: nil, user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 6, section_id: 1, tags: "", user_id: 8},
  {entity_id: 9, section_id: 1, tags: "", user_id: 8},
  {entity_id: 9, section_id: 1, tags: nil, user_id: nil},
  {entity_id: 9, section_id: 1, tags: nil, user_id: nil},
  {entity_id: 9, section_id: 1, tags: "", user_id: nil},
  {entity_id: 1, section_id: 1, tags: "", user_id: 8},
  {entity_id: 7, section_id: 1, tags: "", user_id: 8},
  {entity_id: 7, section_id: 1, tags: "", user_id: 8},
  {entity_id: 7, section_id: 1, tags: "", user_id: 8}
])
Page.create!([
  {titolo: "header", section_id: 1, home: false, header: true, footer: false, slug: "header", modello: false, articolo: false, visibile: true, published_at: "2016-12-07 17:46:31", abstract: nil},
  {titolo: "modello", section_id: 1, home: false, header: false, footer: false, slug: "modello", modello: true, articolo: false, visibile: false, published_at: "2017-01-18 16:39:18", abstract: nil},
  {titolo: "home", section_id: 1, home: true, header: false, footer: false, slug: "home", modello: false, articolo: false, visibile: true, published_at: "2017-04-14 16:07:02", abstract: nil},
  {titolo: "footer", section_id: 1, home: false, header: false, footer: true, slug: "footer", modello: false, articolo: false, visibile: true, published_at: "2017-06-25 14:29:01", abstract: nil},
  {titolo: "Home sezione 1", section_id: 6, home: true, header: false, footer: false, slug: "home-sezione-1", modello: false, articolo: false, visibile: true, published_at: "2017-06-25 15:16:34", abstract: nil},
  {titolo: "Profilo aggiornato", section_id: 1, home: false, header: false, footer: false, slug: "profilo-aggiornato", modello: false, articolo: false, visibile: true, published_at: "2017-08-13 08:57:02", abstract: nil}
])
Property.create!([
  {nome: "Cognome", tipo: "stringa", nativo: true, entity_id: 1, maiuscolo: true, obbligatorio: true, riservata: false, condizioni: "", ordine: 1, descrizione: "", placeholder: "es. Rossi", indice: true},
  {nome: "Nome", tipo: "stringa", nativo: true, entity_id: 1, maiuscolo: true, obbligatorio: true, riservata: nil, condizioni: nil, ordine: 2, descrizione: "", placeholder: "es. Claudio", indice: true},
  {nome: "Data di nascita", tipo: "data", nativo: true, entity_id: 1, maiuscolo: false, obbligatorio: true, riservata: false, condizioni: " ", ordine: 4, descrizione: "", placeholder: "", indice: false},
  {nome: "Sesso", tipo: "sesso", nativo: true, entity_id: 1, maiuscolo: false, obbligatorio: true, riservata: false, condizioni: nil, ordine: 3, descrizione: "", placeholder: nil, indice: false},
  {nome: "Telefono", tipo: "telefono", nativo: false, entity_id: 1, maiuscolo: false, obbligatorio: true, riservata: nil, condizioni: nil, ordine: 7, descrizione: "", placeholder: "es. 0421 338980", indice: false},
  {nome: "Luogo di nascita", tipo: "stringa", nativo: false, entity_id: 1, maiuscolo: true, obbligatorio: true, riservata: nil, condizioni: nil, ordine: 5, descrizione: nil, placeholder: "es. Oderzo (TV)", indice: false},
  {nome: "Tipologia", tipo: "lista", nativo: false, entity_id: 1, maiuscolo: false, obbligatorio: true, riservata: nil, condizioni: "sdb,fma,religioso,sacerdote,laico", ordine: 6, descrizione: "Indica se sei un salesiano/a, un religioso/a o un sacerdote. In caso contrario scegli \"laico\".", placeholder: nil, indice: false},
  {nome: "Privacy", tipo: "check", nativo: false, entity_id: 1, maiuscolo: false, obbligatorio: true, riservata: nil, condizioni: nil, ordine: 10, descrizione: "Acconsento al trattamento dei miei dati personali secondo quanto previsto dalla privacy policy.", placeholder: nil, indice: false},
  {nome: "Realtà di appartenenza", tipo: "select", nativo: false, entity_id: 1, maiuscolo: false, obbligatorio: true, riservata: nil, condizioni: "appartenenza,all", ordine: 8, descrizione: "Seleziona la tua realtà di provenienza... se non è in elenco scegli \"nuova realtà\" e scrivila nel campo qui sotto.", placeholder: nil, indice: false},
  {nome: "Nuova realtà", tipo: "stringa", nativo: false, entity_id: 1, maiuscolo: true, obbligatorio: false, riservata: nil, condizioni: nil, ordine: 9, descrizione: "Se la tua provenienza non è in elenco seleziona \"nuova realtà\" nel campo precedente e scrivila qui.", placeholder: "es. Parrocchia di Roncadelle (TV)", indice: false},
  {nome: "nome", tipo: "stringa", nativo: true, entity_id: 6, maiuscolo: true, obbligatorio: true, riservata: false, condizioni: "", ordine: 1, descrizione: "", placeholder: "es. Mogliano (VE) - Oratorio", indice: true},
  {nome: "Cognome", tipo: "stringa", nativo: false, entity_id: 9, maiuscolo: true, obbligatorio: true, riservata: false, condizioni: nil, ordine: 1, descrizione: nil, placeholder: "es. Rossi", indice: true},
  {nome: "Nome", tipo: "stringa", nativo: false, entity_id: 9, maiuscolo: true, obbligatorio: true, riservata: false, condizioni: nil, ordine: 2, descrizione: nil, placeholder: "es. Claudio", indice: true},
  {nome: "Sesso", tipo: "sesso", nativo: false, entity_id: 9, maiuscolo: false, obbligatorio: true, riservata: false, condizioni: nil, ordine: 3, descrizione: nil, placeholder: nil, indice: false},
  {nome: "Dati utente", tipo: "utente", nativo: false, entity_id: 7, maiuscolo: false, obbligatorio: false, riservata: false, condizioni: nil, ordine: 1, descrizione: nil, placeholder: nil, indice: true}
])
Row.create!([
  {ordine: 1, page_id: 90, estesa: false, colore_sfondo: "#3d3d3d", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: "show-for-medium"},
  {ordine: 1, page_id: 93, estesa: false, colore_sfondo: "#ffffff", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""},
  {ordine: 5, page_id: 98, estesa: false, colore_sfondo: "#ffffff", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""},
  {ordine: 4, page_id: 98, estesa: false, colore_sfondo: "#CCCCCC", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""},
  {ordine: 2, page_id: 98, estesa: false, colore_sfondo: "#ffffff", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""},
  {ordine: 1, page_id: 102, estesa: false, colore_sfondo: "#333333", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: "show-for-medium"},
  {ordine: 1, page_id: 103, estesa: false, colore_sfondo: "#ffffff", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""},
  {ordine: 1, page_id: 98, estesa: false, colore_sfondo: "#B3DB4F", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""},
  {ordine: 1, page_id: 114, estesa: false, colore_sfondo: "#ffffff", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""},
  {ordine: 3, page_id: 98, estesa: false, colore_sfondo: "#216E75", immagine_sfondo_file_name: nil, immagine_sfondo_content_type: nil, immagine_sfondo_file_size: nil, immagine_sfondo_updated_at: nil, visibilita: ""}
])
Section.create!([
  {titolo: "Principale", descrizione: "Sezione principale del sito.", principale: true, percorso: ""},
  {titolo: "Sezione 1", descrizione: "Sezione di test 1", principale: false, percorso: "sezione1"}
])
Tag.create!([
  {nome: "neve", taggable_id: 80, taggable_type: "Robamia"},
  {nome: "scuola", taggable_id: 80, taggable_type: "Robamia"}
])
ee