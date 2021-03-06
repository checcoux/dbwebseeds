class EntitiesController < ApplicationController
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # GET /entities
  # GET /entities.json
  def index
    authorize Entity

    @entities = Entity.all
  end

  def vetrina
    if current_user && current_user.admin?
      @entities = Entity.where("vetrina = ? AND stato < 3", true).order(:ordine, id: :desc)
    else
      @entities = Entity.where("vetrina = ? AND stato IN (1,2)", true).order(:ordine, id: :desc)
    end
  end

  # GET /entities/1
  # GET /entities/1.json
  def show
  end

  # GET /entities/new
  def new
    authorize Entity

    @entity = Entity.new
  end

  # GET /entities/1/edit
  def edit
  end

  # POST /entities
  # POST /entities.json
  def create
    @entity = Entity.new(entity_params)
    @entity.user = current_user

    authorize @entity

    respond_to do |format|
      if @entity.save
        format.html { redirect_to @entity, notice: 'Entity was successfully created.' }
        format.json { render :show, status: :created, location: @entity }
      else
        format.html { render :new }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entities/1
  # PATCH/PUT /entities/1.json
  def update
    if(params[:rigenera_slug])
      @entity.slug = nil
    end

    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to vetrina_path, notice: 'Entity was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1
  # DELETE /entities/1.json
  def destroy
    @entity.destroy
    respond_to do |format|
      format.html { redirect_to entities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity
      @entity = Entity.find(params[:id])

      authorize @entity
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entity_params
      params.require(:entity).permit(:titolo, :nativo, :rigenera_slug, :landing_page, :vetrina, :stato, :descrizione, :descrizione_lunga, :date, :plurale, :immagine, :icona_on, :icona_off, :tipo, :testo_pagamento, :ordine)
    end
end
