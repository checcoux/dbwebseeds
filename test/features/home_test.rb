require "test_helper"

class HomeTest < Capybara::Rails::TestCase
  test "visita della home page" do
    visit '/'

    assert_includes 200...300, page.status_code

    assert page.has_link?('Login')
    assert page.has_link?('sezione 1')
    assert page.has_text?("A nove anni ho fatto un sogno")
    assert page.has_text?("Contenuto della colonna 2c.")
    assert page.has_text?("Footer della pagina")

    assert page.has_no_css?('#main-menu')
  end

  test "login dell'amministratore" do
    logon_as_administrator

    assert page.has_css?('#main-menu')

    within('#main-menu') do
      assert page.has_text?("Preview")
      assert page.has_text?("Principale")

      assert page.has_link?("Nuova sezione")
      assert page.has_link?("Nuova pagina")
      assert page.has_link?("Nuovo articolo")
      assert page.has_link?("Nuovo album")
      assert page.has_link?("Nuovo allegato")
      assert page.has_link?("Logout")
    end
  end

  test "login di un designer" do
    logon_as_designer

    assert page.has_css?('#main-menu')

    within('#main-menu') do
      assert page.has_text?("Preview")
      assert page.has_no_text?("Principale")

      assert page.has_no_link?("Nuova sezione")
      assert page.has_link?("Nuova pagina")
      assert page.has_link?("Nuovo articolo")
      assert page.has_link?("Nuovo album")
      assert page.has_link?("Nuovo allegato")
      assert page.has_no_link?("Nuovo utente")
      assert page.has_link?("Logout")
    end
  end

  test "login di un editor" do
    logon_as_editor

    assert page.has_css?('#main-menu')

    within('#main-menu') do
      assert page.has_text?("Preview")
      assert page.has_no_text?("Principale")

      assert page.has_no_link?("Nuova sezione")
      assert page.has_link?("Nuova pagina")
      assert page.has_link?("Nuovo articolo")
      assert page.has_link?("Nuovo album")
      assert page.has_link?("Nuovo allegato")
      assert page.has_no_link?("Nuovo utente")
      assert page.has_link?("Logout")
    end
  end
end
