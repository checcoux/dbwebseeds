require "test_helper"

class PagesTest < Capybara::Rails::TestCase
  # todo: provare creazione di una nuova pagina


  test "l'amministratore gestisce le pagine" do
    logon_as_administrator

    visit '/pages'

    assert page.has_link?("NUOVA PAGINA")
    assert page.has_text?("/home-sezione-1")
    assert page.has_text?("/footer")
    assert page.has_text?("/header")
    assert page.has_text?("/home")
    assert page.has_text?("/modello")

    page.find_link('Duplica', :href => '/pages/home-sezione-1/duplica').click

    fill_in 'page_titolo', :with => "Pagina modificata"
    select "Principale", :from => 'page_section_id'
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-modificata")

    page.find_link('Elimina', :href => '/pages/pagina-modificata?section_id=1').click

    assert page.has_no_text?("/pagina-modificata")
  end

  test "il designer gestisce le pagine di sua competenza" do
    logon_as_designer

    visit '/pages'

    assert page.has_link?("NUOVA PAGINA")
    assert page.has_text?("/home-sezione-1")
    assert page.has_no_text?("/footer")
    assert page.has_no_text?("/header")
    assert page.has_no_text?("/modello")

    page.find_link('Duplica', :href => '/pages/home-sezione-1/duplica').click

    fill_in 'page_titolo', :with => "Pagina modificata"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-modificata")

    page.find_link('Elimina', :href => '/pages/pagina-modificata?section_id=6').click

    assert page.has_no_text?("/pagina-modificata")
  end

  test "l'editor gestisce le pagine di sua competenza" do
    logon_as_editor

    visit '/pages'

    assert page.has_link?("NUOVA PAGINA")
    assert page.has_text?("/home-sezione-1")
    assert page.has_no_text?("/footer")
    assert page.has_no_text?("/header")
    assert page.has_no_text?("/modello")

    page.find_link('Duplica', :href => '/pages/home-sezione-1/duplica').click

    fill_in 'page_titolo', :with => "Pagina modificata"
    check 'rigenera_slug'
    click_on "SALVA"

    assert page.has_text?("/pagina-modificata")

    page.find_link('Elimina', :href => '/pages/pagina-modificata?section_id=6').click

    assert page.has_no_text?("/pagina-modificata")
  end
end
