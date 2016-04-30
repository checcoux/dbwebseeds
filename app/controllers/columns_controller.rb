class ColumnsController < ApplicationController
  # before_action :set_column, only: [:show, :edit, :update, :editor_update, :destroy, :estendi_riga]
  before_action :set_column, except: [:index, :new, :create]

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
      @column.contenuto = params[:contenuto]
      @column.save()
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
    @row = @column.row
    @row.estesa = true
    @row.save()
    respond_to do |format|
      # format.html { redirect_to columns_url, notice: 'Row was successfully extended.' }
      format.js
      # format.json { head :no_content }
    end
  end

  def riduci_riga
    @row = @column.row
    @row.estesa = false
    @row.save()
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def column_params
      params.require(:column).permit(:ordine, :contenuto, :larghezza, :row_id)
    end
end
