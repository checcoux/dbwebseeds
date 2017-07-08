require "test_helper"

class PhotoalbumsTest < Capybara::Rails::TestCase
  def setup
    @sezione_principale = Section.find_by titolo: 'Principale'
    @sezione1 = Section.find_by titolo: 'Sezione 1'
  end

  test "l'amministratore gestisce gli album fotografici" do
    logon_as_administrator

    visit "/photoalbums"

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVO ALBUM")
    assert page.has_text?("Album fotografici")

    # creazione di un nuovo album
    click_on("NUOVO ALBUM")

    fill_in 'photoalbum_titolo', :with => "Album della prima sezione"
    select "Sezione 1", :from => 'photoalbum_section_id'
    click_on "SALVA"

    assert page.has_text?("Album della prima sezione")

    # modifica delle proprietà di un album
    page.find_link('Proprietà', :href => '/photoalbums/album-della-prima-sezione/edit').click
    fill_in 'photoalbum_titolo', :with => "Album modificato"
    select "Principale", :from => 'photoalbum_section_id'
    click_on "SALVA"

    assert page.has_text?("Album modificato")

    # eliminazione di un album
    page.find_link('Elimina', :href => "/photoalbums/album-della-prima-sezione").click

    assert page.has_text?("Album fotografici")
    assert page.has_no_text?("Album modificato")
  end

  test "l'editor gestisce gli album fotografici" do
    logon_as_editor

    visit "/photoalbums"

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVO ALBUM")
    assert page.has_text?("Album fotografici")

    # creazione di un nuovo album
    click_on("NUOVO ALBUM")

    fill_in 'photoalbum_titolo', :with => "Album della prima sezione"
    select "Sezione 1", :from => 'photoalbum_section_id'
    click_on "SALVA"

    assert page.has_text?("Album della prima sezione")

    # modifica delle proprietà di un album
    page.find_link('Proprietà', :href => '/photoalbums/album-della-prima-sezione/edit').click
    fill_in 'photoalbum_titolo', :with => "Album modificato"
    click_on "SALVA"

    assert page.has_text?("Album modificato")

    # eliminazione di un album
    page.find_link('Elimina', :href => "/photoalbums/album-della-prima-sezione").click

    assert page.has_text?("Album fotografici")
    assert page.has_no_text?("Album modificato")
  end
end