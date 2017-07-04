# ColumnImages: immagini appartenenti alle singole colonne; gruppi di ColumnImages costituiscono uno slider

class ColumnImagesController < ApplicationController
  # before_action :set_column_image, only: [:show, :edit, :update, :destroy]
  before_action :set_column_image, except: [:index, :new, :create]
  before_action :authenticate_user!

  # GET /column_images
  # GET /column_images.json
  def index
    authorize ColumnImage
    @column_images = ColumnImage.all
  end

  # GET /column_images/1
  # GET /column_images/1.json
  def show
  end

  # GET /column_images/new
  def new
    authorize ColumnImage
    @column_image = ColumnImage.new
  end

  # GET /column_images/1/edit
  def edit
  end

  # POST /column_images
  # POST /column_images.json
  def create
    authorize ColumnImage
    @column_image = ColumnImage.new(column_image_params)

    respond_to do |format|
      if @column_image.save
        if @column_image.column.row
          # format.html { redirect_to @column_image.column.row }
          @row = @column_image.column.row
          @page = @row.page
          # format.html { render 'rows/show', layout: false }
          format.html { render 'rows/_row', locals: { row: @row }, layout: false }

          format.json { render :show, status: :created, location: @column_image.column.row }
        else
          @page = @column_image.column.page
          format.html { render 'pages/_row0', layout: false }
          # format.json { render :show, status: :created, location: @column_image.column.row }
        end
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
        if @column_image.column.row
          # format.html { redirect_to @column_image.column.row }
          @row = @column_image.column.row
          @page = @row.page
          # format.html { render 'rows/show', layout: false }
          format.html { render 'rows/_row', locals: { row: @row }, layout: false }

          format.json { render :show, status: :ok, location: @column_image.column.row }
        else
          @page = @column_image.column.page
          format.html { render 'pages/_row0', layout: false }
          # format.json { render :show, status: :created, location: @column_image.column.row }
        end
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
      format.html { redirect_to column_images_url }
      format.json { head :no_content }
    end
  end

  def elimina
    @row = @column_image.column.row

    if @row
      @page = @row.page
      @row_id = @row.id
    else
      @row_id = 0
      @page = @column_image.column.page
    end

    @column_image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column_image
      @column_image = ColumnImage.find(params[:id])

      authorize @column_image, :edit?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def column_image_params
      params.require(:column_image).permit(:titolo, :descrizione, :collegamento, :column_id, :immagine)
    end
end
