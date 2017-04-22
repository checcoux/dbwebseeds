class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    authorize Photo
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    render layout: false
  end

  # GET /photos/new
  def new
    authorize Photo
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    authorize Photo
    @photo = Photo.new(immagine: params[:file], photoalbum_id: params[:photoalbum_id])

    respond_to do |format|
      if @photo.save!
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :json => @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo.photoalbum }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    photoalbum = @photo.photoalbum
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photoalbum }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])

      authorize @photo
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:photoalbum_id, :immagine, :file)
    end
end
