class ColumnsController < ApplicationController
  # before_action :set_column, only: [:show, :edit, :update, :editor_update, :destroy, :estendi_riga]
  before_action :set_column, except: [:index, :new, :create, :modifica_immagine]
  before_action :authenticate_user!

  # GET /columns
  # GET /columns.json
  def index
    @columns = Column.all
  end

  # GET /columns/1
  # GET /columns/1.json
  def show
  end

  # GET /columns/new
  def new
    @column = Column.new
  end

  # GET /columns/1/edit
  def edit
  end

  # POST /columns
  # POST /columns.json
  def create
    @column = Column.new(column_params)

    respond_to do |format|
      if @column.save
        format.html { redirect_to @column, notice: 'column was successfully created.' }
        format.json { render :show, status: :created, location: @column }
      else
        format.html { render :new }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /columns/1
  # PATCH/PUT /columns/1.json
  def update
    respond_to do |format|
      if @column.update(column_params)
        format.html { redirect_to @column, notice: 'column was successfully updated.' }
        format.json { render :show, status: :ok, location: @column }
      else
        format.html { render :edit }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /columns/1/editor_update
  # PATCH/PUT /columns/1/editor_update.json
  def editor_update
    respond_to do |format|
      @column.contenuto = params[:contenuto].gsub('<a id="cerca" name="cerca"></a>', '<input type="search" placeholder="Cerca..." style="width:10em;">')
      @column.save

      # se non si stratta di un contenuto dinamico...
      if !@column.page
        page = @column.row.page

        doc = Nokogiri::HTML(params[:contenuto])

        # se la colonna appartiene a un articolo cerca di estrarre titolo, abstract e tags per gli indici
        if page.articolo

          titolo = doc.at_css('h1')
          page.titolo = titolo.text if titolo

          abstract = doc.at_css('span.abstract')
          page.abstract = abstract.text if abstract

          page.save if titolo || abstract

        end

        # verifichiamo se ci sono dei tag da aggiornare

        tags = doc.css('ul.etichetta li')
        if tags
          # se ci sono dei tag rimuoviamo quelli già associati alla pagina (una sola colonna di ogni pagina potrà contenere tag)
          page.tags.destroy_all

          tags.each do |tag_element|
            page.tags << Tag.new(nome: tag_element.text)
            # logger.info "Riconosciuto tag #{tag_element.text}"
          end

        end
      end

      format.html { head :no_content }
      format.json { render :show, status: :ok, location: @column }
    end
  end

  # DELETE /columns/1
  # DELETE /columns/1.json
  def destroy
    @column.destroy
    respond_to do |format|
      format.html { redirect_to columns_url, notice: 'Column was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def estendi_riga
    @row.estesa = true
    @row.save
    respond_to do |format|
      # format.html { redirect_to columns_url, notice: 'Row was successfully extended.' }
      format.js
      # format.json { head :no_content }
    end
  end

  def riduci_riga
    @row.estesa = false
    @row.save
    respond_to do |format|
      format.js
    end
  end

  def inserisci_riga_prima
    posizione = @row.ordine
    page = @row.page

    # prendo la collezione delle righe e aumento di uno l'ordine di tutte quelle con ordine >= posizione, a partire dall'ultima
    rows = Row.where('ordine >= ? AND page_id = ?', posizione, page.id).order(ordine: :asc)
    rows.each do |riga|
      riga.ordine = riga.ordine + 1
      riga.save
      # logger.info riga.errors.inspect
    end

    # creo una riga vuota
    @row2 = Row.create(ordine: posizione, page_id: page.id, colore_sfondo: '#ffffff')
    @row2.save

    # creo una colonna vuota
    column = Column.create(ordine: 1, larghezza: 12, row_id: @row2.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
    column.save
  end

  def sposta_riga_prima
    posizione = @row.ordine
    page = @row.page

    # cerco la riga precedente...
    @row2 = Row.where('ordine < ? AND page_id = ?', posizione, page.id).order(ordine: :desc).first

    # ...e se esiste scambio i numeri d'ordine delle due righe
    if @row2
      @row.ordine, @row2.ordine = @row2.ordine, @row.ordine

      @row.save
      @row2.save
    end
  end

  def sposta_riga_dopo
    posizione = @row.ordine
    page = @row.page

    # cerco la riga successiva...
    @row2 = Row.where('ordine > ? AND page_id = ?', posizione, page.id).order(ordine: :asc).first

    # ...e se esiste scambio i numeri d'ordine delle due righe
    if @row2
      @row.ordine, @row2.ordine = @row2.ordine, @row.ordine

      @row.save
      @row2.save
    end
  end

  def inserisci_riga_dopo
    posizione = @row.ordine
    page = @row.page

    # prendo la collezione delle righe e aumento di uno l'ordine di tutte quelle con ordine > posizione
    rows = Row.where('ordine > ? AND page_id = ?', posizione, page.id).order(ordine: :asc)
    rows.each do |riga|
      riga.ordine = riga.ordine + 1
      riga.save
    end

    # creo una riga vuota
    @row2 = Row.create(ordine: posizione + 1, page_id: page.id, colore_sfondo: '#ffffff')
    @row2.save

    # creo una colonna vuota
    column = Column.create(ordine: 1, larghezza: 12, row_id: @row2.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
    column.save
  end

  def duplica_riga
    posizione = @row.ordine
    page = @row.page

    # prendo la collezione delle righe e aumento di uno l'ordine di tutte quelle con ordine > posizione
    rows = Row.where('ordine > ? AND page_id = ?', posizione, page.id).order(ordine: :asc)
    rows.each do |riga|
      riga.ordine = riga.ordine + 1
      riga.save
    end

    # duplico la riga
    @row2 = @row.dup
    @row2.ordine = posizione + 1
    @row2.immagine_sfondo = @row.immagine_sfondo if @row.immagine_sfondo
    @row2.save

    @row.columns.each do |colonna|
      colonna2 = colonna.dup
      colonna2.row = @row2
      colonna2.save

      # duplicazione di tutte le column_images
      colonna.column_images.each do |column_image|
        column_image2 = column_image.dup
        column_image2.column = colonna2
        column_image2.immagine = column_image.immagine
        column_image2.save
      end
    end
  end

  def elimina_riga
    posizione = @row.ordine

    # se è l'ultima riga non la elimino
    if(@column.row.page.rows.count > 1) then
      @row.destroy

      # rinumero le righe successive
      rows = Row.where('ordine > ? AND page_id = ?', posizione, @row.page).order(ordine: :asc)
      rows.each do |row|
        row.ordine = row.ordine - 1
        row.save
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def inserisci_colonna_prima1
    posizione = @column.ordine

    # procedo solo se la differenza tra la somma delle larghezze delle colonne successive e il loro numero è maggiore di zero
    columns = Column.where('ordine >= ? AND row_id = ?', posizione, @row.id).order(ordine: :asc)

    if columns.sum("larghezza") > columns.count  then
      # aumento di uno l'ordine delle colonne con ordine >= posizione

      resto = 0
      columns.each do |colonna|
        if colonna.larghezza > 1 then
          resto = resto + 1
          colonna.larghezza = colonna.larghezza - 1
        end

        colonna.ordine = colonna.ordine + 1
        colonna.save
      end
      if resto >= 1 then # dovrebbe sempre essere così perché il controllo è stato fatto a monte
        # creo una colonna vuota
        @column2 = Column.create(ordine: posizione, larghezza: resto, row_id: @row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
        @column2.save
      end
    end
  end

  def inserisci_colonna_dopo
    posizione = @column.ordine

    # procedo solo se la differenza tra la somma delle larghezze delle colonne successive e il loro numero è maggiore di zero
    columns = Column.where('ordine > ? AND row_id = ?', posizione, @row.id).order(larghezza: :desc, ordine: :asc)

    if columns.sum("larghezza") > columns.count  then
      # aumento di uno l'ordine delle colonne con ordine > posizione

      columns.each do |colonna|
        logger.debug colonna.larghezza.to_s
      end

      resto = 0
      columns.each do |colonna|
        if colonna.larghezza > 1 and resto == 0 then
          resto = resto + 1
          colonna.larghezza = colonna.larghezza - 1
        end

        colonna.ordine = colonna.ordine + 1
        colonna.save
      end
      if resto >= 1 then # dovrebbe sempre essere così perché il controllo è stato fatto a monte
        # creo una colonna vuota
        @column2 = Column.create(ordine: posizione + 1, larghezza: resto, row_id: @row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
        @column2.save
      end
    else
      # vedo se posso stringere un po' la colonna selezionata
      if @column.larghezza > 1 then
        @column.larghezza = @column.larghezza - 1
        @column.save

        @column2 = Column.create(ordine: posizione + 1, larghezza: 1, row_id: @row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
        @column2.save
      end
    end
  end

  def inserisci_colonna_prima
    posizione = @column.ordine

    # procedo solo se la differenza tra la somma delle larghezze delle colonne precedenti e il loro numero è maggiore di zero
    columns = Column.where('ordine < ? AND row_id = ?', posizione, @row.id).order(larghezza: :desc, ordine: :desc)
    successive = Column.where('ordine >= ? AND row_id = ?', posizione, @row.id).order(ordine: :asc)

    if columns.sum("larghezza") > columns.count  then
      # aumento di uno l'ordine delle colonne con ordine >= posizione
      successive.each do |colonna|
        colonna.ordine = colonna.ordine + 1
        colonna.save
      end

      resto = 0
      columns.each do |colonna|
        if colonna.larghezza > 1 and resto == 0 then
          resto = resto + 1
          colonna.larghezza = colonna.larghezza - 1
        end
        colonna.save
      end
      if resto >= 1 then # dovrebbe sempre essere così perché il controllo è stato fatto a monte
        # creo una colonna vuota
        @column2 = Column.create(ordine: posizione, larghezza: resto, row_id: @row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
        @column2.save
      end
    else
      # vedo se posso stringere un po' la colonna selezionata
      if @column.larghezza > 1 then
        @column.larghezza = @column.larghezza - 1
        @column.save
        successive.each do |colonna|
          colonna.ordine = colonna.ordine + 1
          colonna.save
        end

        @column2 = Column.create(ordine: posizione, larghezza: 1, row_id: @row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
        @column2.save
      end
    end
  end

  def sposta_colonna_prima
    posizione = @column.ordine

    # cerco la colonna precedente...
    column2 = Column.where('ordine < ? AND row_id = ?', posizione, @row.id).order(ordine: :desc).first

    # ...e se esiste scambio i numeri d'ordine delle due righe
    if column2
      @column.ordine, column2.ordine = column2.ordine, @column.ordine

      @column.save
      column2.save
    end
  end

  def sposta_colonna_dopo
    posizione = @column.ordine

    # cerco la colonna seguente...
    column2 = Column.where('ordine > ? AND row_id = ?', posizione, @row.id).order(ordine: :asc).first

    # ...e se esiste scambio i numeri d'ordine delle due righe
    if column2
      @column.ordine, column2.ordine = column2.ordine, @column.ordine

      @column.save
      column2.save
    end
  end

  def inserisci_colonna_dopo0
    posizione = @column.ordine

    # prendo la collezione delle colonne e aumento di uno l'ordine di tutte quelle con ordine >= posizione, a partire dall'ultima
    columns = Column.where('ordine > ? AND row_id = ?', posizione, @row.id).order(ordine: :asc)
    somma_larghezze = 0
    prima = true
    resto = 0
    columns.each do |colonna|
      somma_larghezze = somma_larghezze + colonna.larghezza
      if prima then
        mezza_larghezza = colonna.larghezza / 2
        resto = colonna.larghezza - mezza_larghezza
        if mezza_larghezza < 1 then
          mezza_larghezza = 1
        end

        colonna.larghezza = mezza_larghezza
      end
      colonna.ordine = colonna.ordine + 1
      colonna.save
      prima = false
    end
    if resto < 1 then
      resto = 1
    end

    # creo una colonna vuota
    @column2 = Column.create(ordine: posizione + 1, larghezza: resto, row_id: @row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
    @column2.save
  end

  def allarga_colonna
    posizione = @column.ordine

    # procedo solo se ci sono almeno due colonne
    columns = Column.where('row_id = ?', @row.id)

    if columns.count > 1 then

      # procedo solo se la differenza tra la somma delle larghezze delle colonne successive e il loro numero è maggiore di zero
      columns = Column.where('ordine > ? AND row_id = ?', posizione, @row.id).order(ordine: :asc)

      if columns.sum("larghezza") > columns.count  then

        resto = 0
        columns.each do |colonna|
          if colonna.larghezza > 1 and resto == 0 then
            resto = resto + 1
            colonna.larghezza = colonna.larghezza - 1
            colonna.save
          end
        end

        if resto > 0 then # dovrebbe essere sempre verificata per il controllo fatto a monte
          @column.larghezza = @column.larghezza + 1
          @column.save
        end
      else
        # provo a stringere le precedenti
        columns = Column.where('ordine < ? AND row_id = ?', posizione, @row.id).order(ordine: :desc)
        if columns.sum("larghezza") > columns.count  then

          resto = 0
          columns.each do |colonna|
            if colonna.larghezza > 1 and resto == 0 then
              resto = resto + 1
              colonna.larghezza = colonna.larghezza - 1
              colonna.save
            end
          end

          if resto > 0 then # dovrebbe essere sempre verificata per il controllo fatto a monte
            @column.larghezza = @column.larghezza + 1
            @column.save
          end
        end

      end
    end
  end

  def stringi_colonna
    posizione = @column.ordine

    # procedo solo se ci sono almeno due colonne
    columns = Column.where('row_id = ?', @row.id)
    if columns.count > 1

      vicina = Column.where('ordine > ? AND row_id = ?', posizione, @row.id).order(ordine: :asc).first

      # se non ci sono colonne a destra allargo quella a sinistra
      if not vicina then
        vicina = Column.where('ordine < ? AND row_id = ?', posizione, @row.id).order(ordine: :desc).first
      end

      # stringo la colonna e allargo la vicina
      if(@column.larghezza > 1) then
        vicina.larghezza = vicina.larghezza + 1
        vicina.save

        @column.larghezza = @column.larghezza - 1
        @column.save
        end
    end
  end

  def equalizza_colonne
    #seleziono tutte le colonne
    columns = Column.where('row_id = ?', @row.id).order(ordine: :asc)

    numero = columns.count

    if numero > 1
      larghezza = 12 / numero
      resto = 12 % numero

      columns.each_with_index do |column, index|
        if index == 0
          column.larghezza = larghezza + resto
        else
          column.larghezza = larghezza
        end

        column.save
      end
    end
  end

  def elimina_colonna
    @column_id = @column.id
    posizione = @column.ordine

    # procedo solo se ci sono almeno due colonne
    columns = Column.where('row_id = ?', @row.id)
    if columns.count > 1 then

      vicina = Column.where('ordine > ? AND row_id = ?', posizione, @row.id).order(ordine: :asc).first

      # se non ci sono colonne a destra allargo quella a sinistra
      if not vicina then
        vicina = Column.where('ordine < ? AND row_id = ?', posizione, @row.id).order(ordine: :desc).first
      end

      # stringo la colonna e allargo la vicina
      if(vicina) then
        vicina.larghezza = vicina.larghezza + @column.larghezza
        vicina.save

        @column.destroy
      end

      # rinumero le colonne successive
      columns = Column.where('ordine > ? AND row_id = ?', posizione, @row).order(ordine: :asc)
      columns.each do |column|
        column.ordine = column.ordine - 1
        column.save
      end
    end
  end

  def rendi_dinamica_inserendo # obsoleta
    if @column.fonte == 0
      # crea una nuova colonna, identica a quella selezionata, ma con contenuto nullo
      column2 = @column.dup
      column2.contenuto = ' '
      column2.fonte = 1 # visualizza i contenuti dinamici della stessa pagina
      column2.save

      # la colonna di origine viene inserita nel circuito delle candidate
      @column.page = @page
      @column.row_id = 0

      @column.save
    end
  end

  def rendi_dinamica_eliminando
    if @column.fonte == 0
      # crea una nuova colonna, identica a quella selezionata, ma con contenuto nullo
      column2 = @column.dup
      column2.contenuto = ' '
      column2.fonte = 1 # visualizza i contenuti dinamici della stessa pagina
      column2.save

      # la colonna di origine viene eliminata
      @column.destroy

      @column = column2
    end
  end

  def contenuti_dinamici_pagina
    rendi_dinamica_eliminando

    if @column.fonte > 1
      @column.fonte = 1
      @column.save
    end
  end

  def contenuti_dinamici_sezione
    rendi_dinamica_eliminando

    if @column.fonte > 0
      @column.fonte = 2
      @column.save
    end
  end

  def contenuti_dinamici_sito
    rendi_dinamica_eliminando

    if @column.fonte > 0
      @column.fonte = 4
      @column.save
    end
  end

  def rendi_statica
    if @column.fonte > 0
      @column.fonte = 0
      @column.save
    end
  end

  def dialog_sfondo
    render layout: false
  end

  def dialog_immagine
    if @row
      @row_id = @row.id
    else
      @row_id = 0
    end

    @column_image = ColumnImage.new
    @column_image.column = @column

    render layout: false
  end

  def modifica_immagine
    # l'id ricevuto è quello di un'immagine, non della colonna
    @column_image = ColumnImage.find(params[:id])

    @column = @column_image.column
    @row = @column.row

    if @row
      @row_id = @row.id
    else
      @row_id = 0
    end

    render layout: false
  end

  def elimina_contenuto_dinamico
    @column_id = @column.id
    @column.destroy
  end

  def aggiungi_ruolo_titolo
    @column.ruolo = 'titolo'
    @column.save
  end

  def aggiungi_ruolo_abstract
    @column.ruolo = 'abstract'
    @column.save
  end

  def aggiungi_ruolo_testo
    @column.ruolo = 'testo'
    @column.save
  end

  def cancella_ruolo
    @column.ruolo = ''
    @column.save
  end

  private
    def set_column
      @column = Column.find(params[:id])
      @row = @column.row

      if @row
        @page = @column.row.page
      else
        @page = @column.page
      end
    end

    def column_params
      params.require(:column).permit(:ordine, :contenuto, :larghezza, :row_id)
    end
end
