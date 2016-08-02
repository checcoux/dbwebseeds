class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
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
      render :show
    else
      if sezione
        # trovo la home della sezione richiesta
        @page = Page.find_by section: sezione, home: true
        if @page
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
    @pages = Page.order('section_id').all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show

  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    # @layout = Layout.find_by(titolo: 'Layout 1')
    # @page.layout = @layout

    respond_to do |format|
      if @page.save

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

        # creo una riga vuota
        row = Row.create(ordine: 1, page_id: @page.id)
        row.save

        # creo una colonna vuota
        column = Column.create(ordine: 1, larghezza: 12, row_id: row.id, contenuto: '<p>Cantami o Diva del pelide Achille l\'ira funesta...</p>')
        column.save

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:titolo, :descrizione, :section_id, :home, :header, :footer)
    end

    def pagina_non_trovata
      logger.error "Tentativo di accedere alla pagina non esistente #{params[:id]}"
      redirect_to pages_url, notice: 'Pagina non valida'
    end
end
