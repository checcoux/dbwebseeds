require "test_helper"

class ArticlesTest < Capybara::Rails::TestCase
  def setup
    @sezione_principale = Section.find_by titolo: 'Principale'
    @sezione1 = Section.find_by titolo: 'Sezione 1'
  end

  test "l'amministratore gestisce gli articoli" do
    logon_as_administrator

    visit "/pages?articolo=1&section_id=#{@sezione1.id}"

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVO ARTICOLO")
    assert page.has_text?("Articoli Sezione 1")

    # creazione di un nuovo articolo
    click_on("NUOVO ARTICOLO")

    fill_in 'page_titolo', :with => "Articolo della prima sezione"
    select "Sezione 1", :from => 'page_section_id'
    click_on "SALVA"

    assert page.has_text?("Articolo della prima sezione")
    assert page.has_text?("Al momento non visibile!")

    # pubblicazione e nascondimento dell'articolo
    click_on "PUBBLICA"

    assert page.has_text?("Pubblicato il")

    click_on "NASCONDI"

    assert page.has_text?("Al momento non visibile!")

    visit '/pages?articolo=1'

    assert page.has_text?("/articolo-della-prima-sezione")

    # modifica delle proprietà di un articolo
    page.find_link('Proprietà', :href => '/pages/articolo-della-prima-sezione/edit').click
    fill_in 'page_titolo', :with => "Articolo modificato"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/articolo-modificato")

    # duplicazione di un articolo
    visit '/pages?articolo=1'
    page.find_link('Duplica', :href => '/pages/articolo-modificato/duplica?articolo=1').click

    fill_in 'page_titolo', :with => "Articolo duplicato"
    select "Principale", :from => 'page_section_id'
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("Articoli Principale")
    assert page.has_text?("/articolo-duplicato")
    assert page.has_text?("Articolo duplicato")

    # eliminazione di un articolo
    page.find_link('Elimina', :href => "/pages/articolo-duplicato?articolo=1&section_id=#{@sezione_principale.id}").click

    assert page.has_text?("Articoli Principale")
    assert page.has_no_text?("/articolo-duplicato")
  end

  test "l'editor gestisce gli articoli" do
    logon_as_editor

    visit "/pages?articolo=1&section_id=#{@sezione1.id}"

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVO ARTICOLO")
    assert page.has_text?("Articoli Sezione 1")

    # creazione di un nuovo articolo
    click_on("NUOVO ARTICOLO")

    fill_in 'page_titolo', :with => "Articolo della prima sezione"
    select "Sezione 1", :from => 'page_section_id'
    click_on "SALVA"

    assert page.has_text?("Articolo della prima sezione")
    assert page.has_text?("Al momento non visibile!")

    # pubblicazione e nascondimento dell'articolo
    click_on "PUBBLICA"

    assert page.has_text?("Pubblicato il")

    click_on "NASCONDI"

    assert page.has_text?("Al momento non visibile!")

    visit '/pages?articolo=1'

    assert page.has_text?("/articolo-della-prima-sezione")

    # modifica delle proprietà di un articolo
    page.find_link('Proprietà', :href => '/pages/articolo-della-prima-sezione/edit').click
    fill_in 'page_titolo', :with => "Articolo modificato"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/articolo-modificato")

    # duplicazione di un articolo
    visit '/pages?articolo=1'
    page.find_link('Duplica', :href => '/pages/articolo-modificato/duplica?articolo=1').click

    fill_in 'page_titolo', :with => "Articolo duplicato"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("Articoli Sezione 1")
    assert page.has_text?("/articolo-duplicato")
    assert page.has_text?("Articolo duplicato")

    # eliminazione di un articolo
    page.find_link('Elimina', :href => "/pages/articolo-duplicato?articolo=1&section_id=#{@sezione1.id}").click

    assert page.has_text?("Articoli Sezione 1")
    assert page.has_no_text?("/articolo-duplicato")
  end
end