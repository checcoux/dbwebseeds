require "test_helper"

class AttachmentsTest < Capybara::Rails::TestCase
  def setup
    @sezione_principale = Section.find_by titolo: 'Principale'
    @sezione1 = Section.find_by titolo: 'Sezione 1'
  end

  test "l'amministratore gestisce gli allegati" do
    logon_as_administrator

    visit "/attachments"

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVO ALLEGATO")
    assert page.has_text?("Allegati")

    # creazione di un nuovo allegato
    click_on("NUOVO ALLEGATO")

    fill_in 'attachment_titolo', :with => "Allegato della prima sezione"
    fill_in 'attachment_descrizione', :with => "Descrizione dell'allegato"
    attach_file 'attachment_allegato', 'test/features/allegato.docx'
    select "Sezione 1", :from => 'attachment_section_id'
    click_on "SALVA"

    assert page.has_text?("Allegato della prima sezione")

    # modifica delle proprietà di un allegato
    click_on "Modifica"
    fill_in 'attachment_titolo', :with => "Allegato modificato"
    select "Principale", :from => 'attachment_section_id'
    click_on "SALVA"

    assert page.has_text?("Allegato modificato")

    # eliminazione di un allegato
    click_on "Elimina"

    assert page.has_text?("Allegati")
    assert page.has_no_text?("Allegato modificato")
  end

  test "l'editor gestisce gli allegati" do
    logon_as_editor

    visit "/attachments"

    # verifica dell'esistenza di alcuni elementi
    assert page.has_link?("NUOVO ALLEGATO")
    assert page.has_text?("Allegati")

    # creazione di un nuovo allegato
    click_on("NUOVO ALLEGATO")

    fill_in 'attachment_titolo', :with => "Allegato della prima sezione"
    fill_in 'attachment_descrizione', :with => "Descrizione dell'allegato"
    attach_file 'attachment_allegato', 'test/features/allegato.docx'
    select "Sezione 1", :from => 'attachment_section_id'
    click_on "SALVA"

    assert page.has_text?("Allegato della prima sezione")

    # modifica delle proprietà di un allegato
    click_on "Modifica"
    fill_in 'attachment_titolo', :with => "Allegato modificato"
    click_on "SALVA"

    assert page.has_text?("Allegato modificato")

    # eliminazione di un allegato
    click_on "Elimina"

    assert page.has_text?("Allegati")
    assert page.has_no_text?("Allegato modificato")
  end
end