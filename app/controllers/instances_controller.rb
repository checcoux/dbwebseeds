class InstancesController < ApplicationController
  before_action :set_instance, only: [:show, :edit, :update, :destroy]

  # GET /instances
  # GET /instances.json
  def index
    if !params[:type].nil?
      @entity = Entity.find_by slug: params[:type]

      authorize @entity, :show?

      @instances = @entity.elenco

      if !current_user.admin? || @entity.slug == 'persona'
        @instances = @instances.where user_id: current_user.id
      end

      @numero = @instances.count

      respond_to do |format|
        format.html {
          @instances = @instances.page(params[:page])
        }
        format.xlsx { # niente paginazione
          response.headers['Content-Disposition'] = 'attachment; filename="' + @entity.plurale + '.xlsx"'
        }
      end

    else
      redirect_to '/'
    end
  end

  # GET /instances/1
  # GET /instances/1.json
  def show
    @entity = @instance.entity
  end

  # GET /instances/new
  def new
    @instance = Instance.new
    @instance.user = current_user
    @page = trova_home

    if !params[:type].nil?
      @entity = Entity.find_by! slug: params[:type]
      @instance.entity_id = @entity ? @entity.id : 0

      authorize @entity, :edit_instances?
    else
      # todo: errore, tipo di oggetto non specificato
      @instance.entity_id = 0
    end
  end

  # GET /instances/1/edit
  def edit
    @entity = @instance.entity
    @page = trova_home
  end

  # POST /instances
  # POST /instances.json
  def create
    @instance = Instance.new(instance_params)
    @instance.section||= trova_sezione_principale
    @instance.user = current_user

    authorize @instance

    @entity = @instance.entity
    if valid_properties? @entity
      respond_to do |format|
        if @instance.save

          # scrittura dei valori delle singole proprietà
          properties = @entity.properties
          properties = properties.where(riservata: false) if !current_user.admin?
          properties.each do |property|
            if property.tipo!='utente'
              datum = Datum.new
              datum.instance = @instance
              datum.property = property
              datum.valore = params[:dato][property.id.to_s]
              datum.valore = datum.valore.strip if datum.valore
              datum.valore = datum.valore.mb_chars.upcase.to_s if property.maiuscolo
              datum.save
            end
          end

          landing_page = !@entity.landing_page.empty? ? @entity.landing_page : instances_url(type: @entity.slug)

          format.html { redirect_to landing_page }
          format.json { render :show, status: :created, location: @instance }
        else
          format.html { render :new }
          format.json { render json: @instance.errors, status: :unprocessable_entity }
        end
      end
    else
      render :new
    end
  end

  # PATCH/PUT /instances/1
  # PATCH/PUT /instances/1.json
  def update
    @entity = @instance.entity

    if valid_properties? @entity
      respond_to do |format|
        if @instance.update(instance_params)

          # scrittura dei valori delle singole proprietà
          properties = @entity.properties
          properties = properties.where(riservata: false) if !current_user.admin?
          properties.each do |property|
            if property.tipo!='utente'
              datum = Datum.find_by instance_id: @instance.id, property_id: property.id
              if !datum
                datum = Datum.new
                datum.instance = @instance
                datum.property = property
              end
              datum.valore = params[:dato][property.id.to_s]
              datum.valore = datum.valore.strip if datum.valore
              datum.valore = datum.valore.mb_chars.upcase.to_s if property.maiuscolo
              datum.save
            end
          end

          landing_page = !@entity.landing_page.empty? ? @entity.landing_page : instances_url(type: @entity.slug)

          format.html { redirect_to landing_page }
          format.json { render :show, status: :ok, location: @instance }
        else
          format.html { render :edit }
          format.json { render json: @instance.errors, status: :unprocessable_entity }
        end
      end
    else
      render :edit
    end
  end

  # DELETE /instances/1
  # DELETE /instances/1.json
  def destroy
    type = @instance.entity.slug

    @instance.destroy
    respond_to do |format|
      format.html { redirect_to instances_url(type: type), notice: 'Instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      @instance = Instance.find(params[:id])

      authorize @instance
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:instance).permit(:entity_id, :section_id, :tags, :type, :dato )
    end

    def valid_properties?(entity)
      parametri = {}
      validatori = {}

      properties = entity.properties
      properties = properties.where(riservata: false) if !current_user.admin?
      properties.each do |property|
        if property.tipo!='utente'
          # da rimuovere: 'p' + property.id.to_s
          parametri['p' + property.id.to_s] = params[:dato][property.id.to_s]

          validatori['p' + property.id.to_s] = {:presence => true} if property.obbligatorio
        end
      end

      @validator = DataValidator.make(
          parametri,
          validatori
      )

      @validator.valid?
    end
end
