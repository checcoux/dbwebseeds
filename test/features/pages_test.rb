require "test_helper"

class PagesTest < Capybara::Rails::TestCase
  test "l'amministratore gestisce le sezioni" do
    logon_as_administrator

    visit '/sections'

    # verifica dell'esistenza di alcuni elementi
    assert page.has_text?("Sezione principale del sito")
    assert page.has_text?("/sezione1")

    # creazione di una nuova sezione
    click_on("NUOVA SEZIONE")

    fill_in 'section_titolo', :with => "Sezione nuova"
    fill_in 'section_percorso', :with => "seznuova"
    fill_in 'section_descrizione', :with => "Sezione appena creata"
    click_on "SALVA"

    assert page.has_text?("Sezione appena creata")

    # modifica delle proprietà di una sezione
    page.find_link('Proprietà', :href => '/sections/7/edit').click
    fill_in 'section_percorso', :with => "seznuova2"
    click_on "SALVA"

    assert page.has_text?("/seznuova2")

    # eliminazione di una sezione
    page.find_link('Elimina', :href => '/sections/7').click

    assert page.has_no_text?("Sezione appena creata")
  end
end
