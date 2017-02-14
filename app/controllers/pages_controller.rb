class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :row0, :nuovo_contenuto_dinamico, :pubblica, :nascondi, :duplica]
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

    if @page && (@page.visibile || user_signed_in?)
      @section = @page.section
      render :show
    else
      if sezione
        # trovo la home della sezione richiesta
        @page = Page.find_by section: sezione, home: true
        if @page && (@page.visibile || user_signed_in?)
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
    authorize Page

    if params[:articolo]
      @mostra_articoli = true
      ordine = 'published_at DESC'
    else
      @mostra_articoli = false
      ordine = 'titolo'
    end
    if params[:section_id]
      @pages = policy_scope(Page).where("section_id = ? AND articolo = ?", params[:section_id], @mostra_articoli).page(params[:page]).order(ordine).all
      @section = policy_scope(Section).find(params[:section_id])
    else
      @pages = policy_scope(Page).where("articolo = ?", @mostra_articoli).page(params[:page]).order(ordine).all
    end
  end

  def search
    sezione = Section.find_by principale: true
    @page = Page.find_by section: sezione, home: true
    @pages = []

    @tags = Tag.search(params[:q], params[:t]).page(params[:page])

    #@tags.each do |tag|
      # logger.info "Tag2 = #{tag.taggable_id} #{tag.taggable_type}"
    #  if tag.taggable_type == 'Page'
    #    pagina = Page.find_by id: tag.taggable_id
    #    @pages << pagina if pagina && pagina.visibile
    #  end
    #end


    # if params[:section_id]
    #  sezione = Section.find(params[:section_id])
    #  @page = Page.find_by section: sezione, home: true
    #  @pages = policy_scope(Page).where("section_id = ? AND articolo = ?", params[:section_id], true).page(params[:page]).order('created_at DESC').all
    # else
    #  sezione = Section.find_by principale: true
    #  @page = Page.find_by section: sezione, home: true
    #  @pages = policy_scope(Page).where("articolo = ?", true).page(params[:page]).order('created_at DESC').all
    # end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if !@page.visibile && !user_signed_in?
      redirect_to home_path
    end
  end

  # GET /pages/new
  def new
    section = Section.find(params[:section_id]) if params[:section_id]
    authorize Page

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
      @page.visibile = false
      @page.home = false
      @page.header = false
      @page.footer = false
      @page.modello = false
      @page.articolo = true
      # @page.published_at = Time.now
    else
      @page = Page.new
      @page.section = section if section
      # @page.published_at = Time.now
    end

  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    authorize Page

    @page = Page.new(page_params)
    @page.visibile = false if @page.modello
    @page.articolo = false if @page.modello
    # @layout = Layout.find_by(titolo: 'Layout 1')
    # @page.layout = @layout
    @page.published_at = Time.new # if !@page.articolo

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

            # duplicazione di tutte le colonne
            riga.columns.each do |colonna|
              colonna2 = colonna.dup
              colonna2.row = riga2

              # se nella colonna è presente un tag H1 lo sostituisce col titolo dell'articolo
              doc = Nokogiri::HTML(colonna2.contenuto)
              h1 = doc.at_css('h1')
              if h1
                h1.content = @page.titolo
                colonna2.contenuto = doc.to_html
              end

              # se nella colonna è presente uno span di classe data lo sostituisce con la data di pubblicazione
              span_data = doc.at_css('span.data')
              if span_data
                span_data.content = "del #{ I18n.localize @page.published_at, format: :data_lunga}"
                colonna2.contenuto = doc.to_html
              end

              #if colonna2.ruolo == 'titolo'
              #  colonna2.contenuto.sub! /titolo/i, @page.titolo
              #end

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
          row = Row.create(ordine: 1, page_id: @page.id, colore_sfondo: '#ffffff')
          row.save

          # creo una colonna vuota
          column = Column.create(ordine: 1, larghezza: 12, row_id: row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>', autocrop: true)
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
    if(params[:rigenera_slug])
      @page.slug = nil
    end

    params = page_params
    params[:articolo] = false if params[:modello] == 'true'

    respond_to do |format|
      if @page.update(params)

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

        format.html { redirect_to pages_url(section_id: @page.section, articolo: @page.articolo ? '1' : nil) }
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
    section_id = @page.section.id
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url(section_id: params[:section_id], articolo: params[:articolo]) }
      format.json { head :no_content }
    end
  end

  def pubblica
    @page.visibile = true
    @page.published_at = Time.new
    @page.save

    # se è un articolo creiamo una colonna dinamica nella home della sezione
    home = @section.trova_home
    if @page.articolo && home
      # se esiste estrae l'abstract
      # abstract_column = Column.joins(:row).where(:rows => {:page_id => @page}, :ruolo => 'abstract').first

      #if abstract_column
      #  abstract = ActionController::Base.helpers.strip_tags abstract_column.contenuto
      #else
      #  abstract = ''
      #end
      abstract = @page.abstract || ''

      column = Column.new
      column.ordine = 1
      column.larghezza = 4
      column.row_id = 0
      column.page = home
      column.contenuto = "<h2><a href='#{@page.slug}'>#{@page.titolo}</a></h2><p>#{abstract}</p>"
      column.save

      # se esiste copia anche l'immagine
      column_image = ColumnImage.joins(:column => :row).where(:rows => {:page_id => @page}).first

      if column_image
        column_image2 = column_image.dup
        column_image2.column = column
        column_image2.immagine = column_image.immagine
        column_image2.titolo = @page.titolo
        column_image2.descrizione = abstract
        column_image2.collegamento = "/#{@page.slug}"
        column_image2.save
      end
    end

    redirect_to @page
  end

  def nascondi
    @page.visibile = false
    @page.save

    redirect_to @page
  end

  def duplica
    authorize Page

    @page2 = @page.dup
    @page2.home = false
    @page2.header = false
    @page2.footer = false
    @page2.published_at = Time.new
    @page2.titolo = "Copia di " + @page2.titolo


    # duplicazione di tutte le righe
    @page.rows.each do |riga|
      riga2 = riga.dup
      riga2.page = @page2
      riga2.immagine_sfondo = riga.immagine_sfondo if riga.immagine_sfondo
      riga2.save

      riga.columns.each do |colonna|
        colonna2 = colonna.dup
        colonna2.row = riga2
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

    respond_to do |format|
      # format.html { redirect_to pages_url(section_id: params[:section_id], articolo: params[:articolo]) }
      format.html { redirect_to edit_page_url(@page2) }

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

  def screen
    offset = Integer(params[:n]) - 1
    @column = Column.where("row_id = 0").order('created_at DESC').limit(1).offset(offset).first
    @column.larghezza = 12
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
      @section = @page.section

      authorize @page
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:titolo, :descrizione, :section_id, :home, :header, :footer, :modello, :visibile, :articolo, :published_at, :rigenera_slug, :q, :t)
    end

    def pagina_non_trovata
      logger.error "Tentativo di accedere alla pagina non esistente #{params[:id]}"
      redirect_to home_url
    end
end
