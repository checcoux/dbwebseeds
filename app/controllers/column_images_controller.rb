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

  def sposta_sx
    column = @column_image.column
    @row = column.row

    if @row
      @page = @row.page
      @row_id = @row.id
    else
      @row_id = 0
      @page = @column_image.column.page
    end

    if @column_image.ordine == 0
      # è una colonna creata prima della decisione di dare un ordine alle immagini
      contatore = 1
      ColumnImage.where('column_id = ?', @column_image.column.id).order(created_at: :asc).each do |ci|
        ci.ordine = contatore
        ci.save

        if ci.id == column_image.id
          posizione = ci.ordine
        end

        contatore += 1
      end
    else
      posizione = @column_image.ordine
    end

    # trovo la prima con un ordine minore
    precedente = ColumnImage.where('ordine < ? AND column_id = ?', posizione, column.id).order(ordine: :desc).first
    if precedente
      @column_image.ordine = precedente.ordine
      precedente.ordine = posizione

      @column_image.save
      precedente.save
    else
      # era già la prima, la sposto in fondo
      ultima = ColumnImage.where('column_id = ?', column.id).order(ordine: :desc).first
      @column_image.ordine = ultima.ordine + 1
      @column_image.save
    end
  end

  def sposta_dx
    column = @column_image.column
    @row = column.row

    if @row
      @page = @row.page
      @row_id = @row.id
    else
      @row_id = 0
      @page = @column_image.column.page
    end

    if @column_image.ordine == 0
      # è una colonna creata prima della decisione di dare un ordine alle immagini
      contatore = 1
      ColumnImage.where('column_id = ?', @column_image.column.id).order(created_at: :asc).each do |ci|
        ci.ordine = contatore
        ci.save

        if ci.id == column_image.id
          posizione = ci.ordine
        end

        contatore += 1
      end
    else
      posizione = @column_image.ordine
    end

    # trovo la prima con un ordine maggiore
    successiva = ColumnImage.where('ordine > ? AND column_id = ?', posizione, column.id).order(ordine: :desc).first
    if successiva
      @column_image.ordine = successiva.ordine
      successiva.ordine = posizione

      @column_image.save
      successiva.save
    else
      # era già l'ultima, la sposto all'inizio
      da_spostare = ColumnImage.where('column_id = ? AND id != ?', column.id, @column_image.id).order(ordine: :asc)
      da_spostare.each do |ds|
        ds.ordine = ds.ordine + 1
        ds.save
      end
      @column_image.ordine = 1
      @column_image.save
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
      params.require(:column_image).permit(:titolo, :descrizione, :collegamento, :column_id, :immagine, :ordine)
    end
end
