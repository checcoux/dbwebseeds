require "test_helper"

class PagesTest < Capybara::Rails::TestCase
  def setup
    @sezione_principale = Section.find_by titolo: 'Principale'
    @sezione1 = Section.find_by titolo: 'Sezione 1'
  end

  test "l'amministratore gestisce le pagine" do
    logon_as_administrator

    visit '/pages'

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVA PAGINA")
    assert page.has_text?("/home-sezione-1")
    assert page.has_text?("/footer")
    assert page.has_text?("/header")
    assert page.has_text?("/home")
    assert page.has_text?("/modello")

    # creazione di una nuova pagina
    click_on("NUOVA PAGINA")

    fill_in 'page_titolo', :with => "Pagina nuova"
    select "Principale", :from => 'page_section_id'
    click_on "SALVA"

    assert page.has_text?("Cantami o Diva del pelide Achille")

    visit '/pages'
    assert page.has_text?("/pagina-nuova")

    # modifica delle proprietà di una pagina
    page.find_link('Proprietà', :href => '/pages/pagina-nuova/edit').click
    fill_in 'page_titolo', :with => "Pagina nuova 2"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-nuova-2")

    # duplicazione di una pagina
    visit '/pages'
    page.find_link('Duplica', :href => '/pages/home-sezione-1/duplica').click

    fill_in 'page_titolo', :with => "Pagina modificata"
    select "Principale", :from => 'page_section_id'
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-modificata")

    # eliminazione di una pagina
    page.find_link('Elimina', :href => "/pages/pagina-modificata?section_id=#{@sezione_principale.id}").click

    assert page.has_no_text?("/pagina-modificata")
  end

  test "il designer gestisce le pagine di sua competenza" do
    logon_as_designer

    visit '/pages'

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVA PAGINA")
    assert page.has_text?("/home-sezione-1")
    assert page.has_no_text?("/footer")
    assert page.has_no_text?("/header")
    assert page.has_no_text?("/modello")

    # creazione di una nuova pagina
    click_on("NUOVA PAGINA")

    fill_in 'page_titolo', :with => "Pagina nuova"
    click_on "SALVA"

    assert page.has_text?("Cantami o Diva del pelide Achille")

    visit '/pages'
    assert page.has_text?("/pagina-nuova")

    # modifica delle proprietà di una pagina
    page.find_link('Proprietà', :href => '/pages/pagina-nuova/edit').click
    fill_in 'page_titolo', :with => "Pagina nuova 2"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-nuova-2")

    # duplicazione di una pagina
    visit '/pages'
    page.find_link('Duplica', :href => '/pages/home-sezione-1/duplica').click

    fill_in 'page_titolo', :with => "Pagina modificata"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-modificata")

    # eliminazione di una pagina
    page.find_link('Elimina', :href => "/pages/pagina-modificata?section_id=#{@sezione1.id}").click

    assert page.has_no_text?("/pagina-modificata")
  end

  test "l'editor gestisce le pagine di sua competenza" do
    logon_as_editor

    visit '/pages'

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVA PAGINA")
    assert page.has_text?("/home-sezione-1")
    assert page.has_no_text?("/footer")
    assert page.has_no_text?("/header")
    assert page.has_no_text?("/modello")

    # creazione di una nuova pagina
    click_on("NUOVA PAGINA")

    fill_in 'page_titolo', :with => "Pagina nuova"
    click_on "SALVA"

    assert page.has_text?("Cantami o Diva del pelide Achille")

    visit '/pages'
    assert page.has_text?("/pagina-nuova")

    # modifica delle proprietà di una pagina
    page.find_link('Proprietà', :href => '/pages/pagina-nuova/edit').click
    fill_in 'page_titolo', :with => "Pagina nuova 2"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-nuova-2")

    # duplicazione di una pagina
    visit '/pages'
    page.find_link('Duplica', :href => '/pages/home-sezione-1/duplica').click

    fill_in 'page_titolo', :with => "Pagina modificata"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-modificata")

    # eliminazione di una pagina
    page.find_link('Elimina', :href => "/pages/pagina-modificata?section_id=#{@sezione1.id}").click

    assert page.has_no_text?("/pagina-modificata")
  end
end