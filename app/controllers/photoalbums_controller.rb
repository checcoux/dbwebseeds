class PhotoalbumsController < ApplicationController
  before_action :set_photoalbum, only: [:show, :edit, :update, :destroy, :copertina, :pubblica]

  # GET /photoalbums
  # GET /photoalbums.json
  def index
    authorize Photoalbum

    if params[:section_id]
      @photoalbums = Photoalbum.where("section_id = ?", params[:section_id]).page(params[:page]).order('updated_at DESC').all

      @section = Section.find(params[:section_id])
    else
      @photoalbums = Photoalbum.all.page(params[:page]).order('updated_at DESC').all
    end
  end

  # GET /photoalbums/1
  # GET /photoalbums/1.json
  def show
    @page = @photoalbum.section.trova_home
    @photos = @photoalbum.photos.all
  end

  # GET /photoalbums/new
  def new
    authorize Photoalbum

    section = Section.find(params[:section_id]) if params[:section_id]

    @photoalbum = Photoalbum.new
    @photoalbum.section = section if section
    @photo = @photoalbum.photos.build
  end

  # GET /photoalbums/1/edit
  def edit
  end

  # POST /photoalbums
  # POST /photoalbums.json
  def create
    @photoalbum = Photoalbum.new(photoalbum_params)

    authorize @photoalbum

    respond_to do |format|
      if @photoalbum.save
        # salviamo i tag
        tags = @photoalbum.parole.strip.split(',')
        tags.each do |tag|
          @photoalbum.tags << Tag.new(nome: tag.strip)
        end

        format.html { redirect_to photoalbums_path(section_id: @photoalbum.section_id) }
        format.json { render :show, status: :created, location: @photoalbum }
      else
        format.html { render :new }
        format.json { render json: @photoalbum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photoalbums/1
  # PATCH/PUT /photoalbums/1.json
  def update
    respond_to do |format|
      if @photoalbum.update(photoalbum_params)
        # rimuoviamo tutti i tag associati
        @photoalbum.tags.destroy_all

        # salviamo i tag
        tags = @photoalbum.parole.strip.split(',')
        tags.each do |tag|
          @photoalbum.tags << Tag.new(nome: tag.strip)
        end

        format.html { redirect_to photoalbums_path(section_id: @photoalbum.section_id) }
        format.json { render :show, status: :ok, location: @photoalbum }
      else
        format.html { render :edit }
        format.json { render json: @photoalbum.errors, status: :unprocessable_entity }
      end
    end
  end

  def copertina
    @photoalbum.copertina = params[:photo_id].to_i
    @photoalbum.save

    redirect_to photoalbums_path(section_id: @photoalbum.section_id)
  end

  def pubblica
    # creiamo una colonna dinamica nella home della sezione
    home = @photoalbum.section.trova_home
    if home
      column = Column.new
      column.ordine = 1
      column.larghezza = 4
      column.row_id = 0
      column.page = home
      column.contenuto = "<h2><a href='/photoalbums/#{@photoalbum.slug}'>#{@photoalbum.titolo}</a></h2><p>Pubblicate le foto!</p>"
      column.save

      column_image = ColumnImage.new
      column_image.column = column
      column_image.titolo = @photoalbum.titolo
      column_image.descrizione = "Pubblicate le foto!"
      column_image.collegamento = "/photoalbums/#{@photoalbum.slug}"

      if @photoalbum.copertina
        photo = Photo.find_by(id: @photoalbum.copertina)
        if photo
          file = File.open(photo.immagine.xlarge.path)
          if file
            column_image.immagine = file
            file.close
            column_image.save # salviamo solo se la foto è stata effettivamente trovata... non si sa mai!
          end
        end
      end

      redirect_to home
    else
      redirect_to photoalbums_path(section_id: @photoalbum.section_id)
    end
  end

  # DELETE /photoalbums/1
  # DELETE /photoalbums/1.json
  def destroy
    section_id = @photoalbum.section.id

    @photoalbum.destroy
    respond_to do |format|
      format.html { redirect_to photoalbums_url(section_id: section_id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photoalbum
      @photoalbum = Photoalbum.find(params[:id])

      authorize @photoalbum
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photoalbum_params
      params.require(:photoalbum).permit(:titolo, :section_id, :parole, photos_attributes: [:id, :photoalbum_id, :immagine])
    end
end
