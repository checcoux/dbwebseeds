# Sections: sezioni del sito; ogni sezione ha le sue pagine, articoli, fotografie, allegati
#           e può essere gestita da uno o più utenti

class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.all
    authorize @sections
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
    authorize Section
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)
    authorize Section

    respond_to do |format|
      if @section.save

        # solo una sezione può avere il flag principale
        if(@section.principale)
          Section.where.not(id: @section.id).update_all(principale: false)
        end

        format.html { redirect_to sections_url }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)

        # solo una sezione può avere il flag principale
        if(@section.principale)
          Section.where.not(id: @section.id).update_all(principale: false)
        end

        format.html { redirect_to sections_url }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
      authorize @section
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:titolo, :percorso, :descrizione, :principale)
    end
end
