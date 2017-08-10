class InstancesController < ApplicationController
  before_action :set_instance, only: [:show, :edit, :update, :destroy]

  # GET /instances
  # GET /instances.json
  def index
    if !params[:type].nil?
      @entity = Entity.find_by slug: params[:type]
      entity_id = @entity ? @entity.id : 0

      @instances = Instance.where("entity_id = ?", entity_id)
    else
      @instances = Instance.all
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

    if !params[:type].nil?
      @entity = Entity.find_by slug: params[:type]
      @instance.entity_id = @entity ? @entity.id : 0
    else
      # todo: errore, tipo di oggetto non specificato
      @instance.entity_id = 0
    end
  end

  # GET /instances/1/edit
  def edit
    @entity = @instance.entity
  end

  # POST /instances
  # POST /instances.json
  def create
    @instance = Instance.new(instance_params)

    @entity = @instance.entity
    if valid_properties? @entity
      respond_to do |format|
        if @instance.save

          # scrittura dei valori delle singole proprietà
          @entity.properties.each do |property|
            Datum.create(instance_id: @instance.id, property_id: property.id, valore: params[:dato][property.id.to_s])
          end

          format.html { redirect_to instances_url(type: @entity.slug), notice: 'Instance was successfully created.' }
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
          @entity.properties.each do |property|
            datum = Datum.find_by! instance_id: @instance.id, property_id: property.id
            datum.valore = params[:dato][property.id.to_s]
            datum.valore = datum.valore.upcase if property.maiuscolo
            datum.save
          end

          format.html { redirect_to instances_url(type: @entity.slug), notice: 'Instance was successfully updated.' }
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:instance).permit(:entity_id, :section_id, :tags, :type, :dato )
    end

    def valid_properties?(entity)
      parametri = {}
      validatori = {}

      entity.properties.each do |property|
        # da rimuovere: 'p' + property.id.to_s
        parametri[property.nome] = params[:dato][property.id.to_s]

        validatori[property.nome] = {:presence => true} if property.obbligatorio
      end

      @validator = DataValidator.make(
          parametri,
          validatori
      )

      @validator.valid?
    end
end
