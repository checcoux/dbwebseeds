class PhotoalbumsController < ApplicationController
  before_action :set_photoalbum, only: [:show, :edit, :update, :destroy]

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
