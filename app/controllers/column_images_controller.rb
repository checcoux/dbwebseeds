class ColumnImagesController < ApplicationController
  before_action :set_column_image, only: [:show, :edit, :update, :destroy]

  # GET /column_images
  # GET /column_images.json
  def index
    @column_images = ColumnImage.all
  end

  # GET /column_images/1
  # GET /column_images/1.json
  def show
  end

  # GET /column_images/new
  def new
    @column_image = ColumnImage.new
  end

  # GET /column_images/1/edit
  def edit
  end

  # POST /column_images
  # POST /column_images.json
  def create
    @column_image = ColumnImage.new(column_image_params)

    respond_to do |format|
      if @column_image.save
        format.html { redirect_to @column_image.column.row, notice: 'Column image was successfully created.' }
        format.json { render :show, status: :created, location: @column_image }
      else
        format.html { render :new }
        format.json { render json: @column_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /column_images/1
  # PATCH/PUT /column_images/1.json
  def update
    respond_to do |format|
      if @column_image.update(column_image_params)
        format.html { redirect_to @column_image, notice: 'Column image was successfully updated.' }
        format.json { render :show, status: :ok, location: @column_image }
      else
        format.html { render :edit }
        format.json { render json: @column_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /column_images/1
  # DELETE /column_images/1.json
  def destroy
    @column_image.destroy
    respond_to do |format|
      format.html { redirect_to column_images_url, notice: 'Column image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column_image
      @column_image = ColumnImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def column_image_params
      params.require(:column_image).permit(:descrizione, :column_id, :immagine)
    end
end
