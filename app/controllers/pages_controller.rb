class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :row0, :nuovo_contenuto_dinamico]
  rescue_from ActiveRecord::RecordNotFound, with: :pagina_non_trovata

  # GET /
  # GET /:slug
  def route
    slug = params[:slug]

    if slug
      # lo slug potrebbe essere il percorso di una sezione...
      sezione = Section.find_by percorso: slug

      if !sezione
        # ...oppure il titolo di una pagina...
        @page = Page.find(slug)
      end
    else
      sezione = Section.find_by principale: true
    end

    if @page
      @section = @page.section
      render :show
    else
      if sezione
        # trovo la home della sezione richiesta
        @page = Page.find_by section: sezione, home: true
        if @page
          @section = @page.section
          render :show
        else
          # non è stata definita la home della sezione richiesta, allora rimando alla lista delle pagine
          redirect_to pages_url
        end
      else
        # non è stata definita la sezione principale, allora rimando alla lista delle pagine
        redirect_to pages_url
      end
    end
  end

  # GET /pages
  # GET /pages.json
  def index
    if params[:articolo]
      @mostra_articoli = true
      ordine = 'created_at DESC'
    else
      @mostra_articoli = false
      ordine = 'titolo'
    end
    if params[:section_id]
      @pages = Page.where("section_id = ? AND articolo = ?", params[:section_id], @mostra_articoli).page(params[:page]).order(ordine).all
      @section = Section.find(params[:section_id])
    else
      @pages = Page.where("articolo = ?", @mostra_articoli).page(params[:page]).order(ordine).all
    end
  end

  # indice articoli per il pubblico
  def articoli
    if params[:section_id]
      @pages = Page.where("section_id = ? AND articolo = ?", params[:section_id], true).page(params[:page]).order('created_at DESC').all
    else
      @pages = Page.where("articolo = ?", true).page(params[:page]).order('created_at DESC').all
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show

  end

  # GET /pages/new
  def new
    section = Section.find(params[:section_id]) if params[:section_id]

    if params[:articolo]
      # se non è stata trovata la sezione genera un errore
      return redirect_to sections_url if !section

      # trova il modello per gli articoli della sezione... solo per evitare che si passi a create senza modello
      modello = section.trova_modello
      return redirect_to sections_url if !modello

      # duplica il modello
      @page = modello.dup
      @page.titolo = ''
      @page.section = section # il modello potrebbe venire dalla sezione principale

      # impostazione dei flag
      @page.visibile = true
      @page.home = false
      @page.header = false
      @page.footer = false
      @page.modello = false
      @page.articolo = true

      @page.published_at = Time.now
    else
      @page = Page.new
      @page.section = section if section
      @page.published_at = Time.now
    end

  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    @page.visibile = false if @page.modello
    @page.articolo = false if @page.modello
    # @layout = Layout.find_by(titolo: 'Layout 1')
    # @page.layout = @layout

    respond_to do |format|
      if @page.save

        # solo una pagina di una certa sezione può avere il flag home / header / footer / modello
        if(@page.home)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(home: false)
        end
        if(@page.header)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(header: false)
        end
        if(@page.footer)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(footer: false)
        end
        if(@page.modello)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(modello: false)
        end

        if @page.articolo
          # trova il modello per gli articoli della sezione
          modello = @page.section.trova_modello

          # duplicazione di tutte le righe
          modello.rows.each do |riga|
            riga2 = riga.dup
            riga2.page = @page
            riga2.save

            riga.columns.each do |colonna|
              colonna2 = colonna.dup
              colonna2.row = riga2
              if colonna2.ruolo == 'titolo'
                colonna2.contenuto.sub! /titolo/i, @page.titolo
              end
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
        else
          # creo una riga vuota
          row = Row.create(ordine: 1, page_id: @page.id)
          row.save

          # creo una colonna vuota
          column = Column.create(ordine: 1, larghezza: 12, row_id: row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
          column.save
        end

        format.html { redirect_to @page }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)

        # solo una pagina di una certa sezione può avere il flag home / header / footer
        if(@page.home)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(home: false)
        end
        if(@page.header)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(header: false)
        end
        if(@page.footer)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(footer: false)
        end
        if(@page.modello)
          Page.where("id != ? AND section_id = ?", @page.id, @page.section.id).update_all(modello: false)
        end

        format.html { redirect_to pages_url }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  def row0
    render layout: false
  end

  def nuovo_contenuto_dinamico
    column = Column.new(page: @page, row_id: 0, contenuto: '', ordine: 0, larghezza: 3)
    column.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
      @section = @page.section
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:titolo, :descrizione, :section_id, :home, :header, :footer, :modello, :visibile, :articolo, :published_at)
    end

    def pagina_non_trovata
      logger.error "Tentativo di accedere alla pagina non esistente #{params[:id]}"
      redirect_to pages_url, notice: 'Pagina non valida'
    end
end
