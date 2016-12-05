class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy, :download]
  before_action :authenticate_user!

  # GET /attachments
  # GET /attachments.json
  def index
    authorize Attachment

    if params[:section_id]
      @attachments = Attachment.where("section_id = ? AND allegato_file_name IS NOT NULL", params[:section_id]).page(params[:page]).order('updated_at DESC').all

      @section = Section.find(params[:section_id])
    else
      @attachments = Attachment.where("allegato_file_name IS NOT NULL").page(params[:page]).order('updated_at DESC').all
    end
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  def download
    send_file @attachment.allegato.path,
              :filename => @attachment.allegato_file_name,
              :type => @attachment.allegato_content_type,
              :disposition => 'attachment'
  end

  # GET /attachments/new
  def new
    authorize Attachment

    section = Section.find(params[:section_id]) if params[:section_id]

    @attachment = Attachment.new
    @attachment.section = section if section
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(attachment_params)

    authorize @attachment

    respond_to do |format|
      if @attachment.save
        # salviamo i tag
        tags = @attachment.parole.strip.split(',')
        tags.each do |tag|
          @attachment.tags << Tag.new(nome: tag.strip)
        end

        format.html { redirect_to attachments_path(section_id: @attachment.section_id) }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        # rimuoviamo tutti i tag associati
        @attachment.tags.destroy_all

        # salviamo i tag
        tags = @attachment.parole.strip.split(',')
        tags.each do |tag|
          @attachment.tags << Tag.new(nome: tag.strip)
        end

        format.html { redirect_to attachments_path(section_id: @attachment.section_id) }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    section_id = @attachment.section.id

    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url(section_id: section_id) }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attachment
    @attachment = Attachment.find(params[:id])

    authorize @attachment
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attachment_params
    params.require(:attachment).permit(:titolo, :descrizione, :collegamento, :allegato, :section_id, :parole)
  end
end
