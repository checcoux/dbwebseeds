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
    @avvisi_limiti = []

    if !params[:type].nil?
      @entity = Entity.find_by! slug: params[:type]
      @instance.entity_id = @entity ? @entity.id : 0

      authorize @entity, :edit_instances?

      # verifica se ci sono limiti per appartenenza
      if @instance.entity.applica_limiti_appartenenza
        entity_appartenenza = Entity.find_by! slug: 'appartenenza'
        appartenenza = entity_appartenenza.instances.where(id: current_user.appartenenza_id).first
        # nota: non si può semplificare in Instance.find(instance.user.appartenenza_id) perché nel caso non esistesse solleverebbe un'eccezione

        if appartenenza
          limit_property = Property.where("entity_id = ? AND nome like 'limite'", entity_appartenenza.id).first

          if limit_property
            datum = Datum.find_by instance_id: current_user.appartenenza_id, property_id: limit_property.id
            max = datum ? datum.valore.to_i : 0
            conteggio = Instance.where(entity_id: @instance.entity.id, appartenenza_id: current_user.appartenenza_id).count

            if conteggio >= max
              if max > 0
                @avvisi_limiti << "Siamo spiacenti, non ci sono più posti disponibili per #{ appartenenza.label }: #{ conteggio } posti occupati."
              else
                @avvisi_limiti << "#{ appartenenza.label } partecipa per la prima volta. Contatta eventijesolo@donboscoland.it per abilitare l'iscrizione."
              end
            else
              @avvisi_limiti << "Disponibili ancora #{ max - conteggio } su #{ max } posti per #{ appartenenza.label }"
            end
          end
        end
      end
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
    # è possibile creare diverse copie dell'istanza
    numcopie = params[:numcopie].to_i
    numcopie = 1 if !numcopie.between?(1,200)

    copie_salvate = 0

    for i in 1..numcopie

      @instance = Instance.new(instance_params)
      @instance.section||= trova_sezione_principale
      @instance.user = current_user
      @instance.appartenenza_id = current_user.appartenenza_id

      authorize @instance

      @entity = @instance.entity

      @errori_limiti = []
      @limiti_superati = !(nei_limiti? @instance)

      if !@limiti_superati && (valid_properties? @entity)
        if @instance.save
          copie_salvate+=1

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
        else
          break
        end
      else
        break
      end
    end

    if copie_salvate == numcopie # ha completato il ciclo
      landing_page = !@entity.landing_page.empty? ? @entity.landing_page : instances_url(type: @entity.slug)
      redirect_to landing_page
    else
      @errori_limiti << "Salvate #{ copie_salvate } copie su #{ numcopie }"
      render :new
    end
  end

  # PATCH/PUT /instances/1
  # PATCH/PUT /instances/1.json
  def update
    @entity = @instance.entity

    @errori_limiti = []
    @limiti_superati = !(nei_limiti? @instance, true)

    if !@limiti_superati && (valid_properties? @entity)
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
      params.require(:instance).permit(:entity_id, :section_id, :tags, :type, :dato, :numcopie )
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

  def nei_limiti?(instance, is_update = false)
    nei_limiti = true

    # verifica che non sia superato il limite per questa appartenenza (bypassata nel caso dell'update)
    if instance.entity.applica_limiti_appartenenza
      if !is_update

        entity_appartenenza = Entity.find_by! slug: 'appartenenza'
        appartenenza = entity_appartenenza.instances.where(id: instance.user.appartenenza_id).first
        # nota: non si può semplificare in Instance.find(instance.user.appartenenza_id) perché nel caso non esistesse solleverebbe un'eccezione

        if appartenenza
          limit_property = Property.where("entity_id = ? AND nome like 'limite'", entity_appartenenza.id).first

          if limit_property
            datum = Datum.find_by instance_id: instance.user.appartenenza_id, property_id: limit_property.id

            max = datum ? datum.valore.to_i : 0

            conteggio = Instance.where(entity_id: instance.entity.id, appartenenza_id: instance.user.appartenenza_id).count

            if conteggio >= max
              nei_limiti = false
              if max > 0
                @errori_limiti << "Siamo spiacenti, non ci sono più posti disponibili per #{ appartenenza.label }"
              else
                @errori_limiti << "#{ appartenenza.label } partecipa per la prima volta. Contatta eventijesolo@donboscoland.it per abilitare l'iscrizione."
              end
            end
          end
        end
      end
    end

    if instance.entity.applica_limiti
      # per ogni property di tipo select
      select_properties = instance.entity.properties.where(tipo: 'select')
      select_properties.each do |property|
        # trovo l'entity collegata
        parametri = property.condizioni.split(',')
        tabella = parametri[0]
        ent = Entity.find_by! slug: tabella

        # se ha una property limite
        limit_property = ent.properties.where("nome like 'limite'").first
        if limit_property
          # individua l'id dell'istanza scelta
          ist_id = params[:dato][property.id.to_s].to_i

          # legge il valore del limite per l'istanza scelta
          datum = Datum.find_by instance_id: ist_id, property_id: limit_property.id
          max = datum ? datum.valore.to_i : 0

          # se è un update e il valore non è cambiato aumento il limite di uno
          if is_update
            datum = Datum.find_by instance_id: instance.id, property_id: property.id

            if datum
              max+=1 if datum.valore.to_i == ist_id
            end
          end

          # conta quante volte quell'istanza è stata già scelta
          conteggio = Instance.joins(:data).where("instances.entity_id = ? AND data.property_id = ? AND data.valore = ?", instance.entity.id, property.id, ist_id.to_s).count

          if conteggio >= max
            nei_limiti = false

            # legge il nome dell'istanza scelta
            ist = Instance.find(ist_id)

            @errori_limiti << "Raggiunto il limite per #{ property.nome }: #{ ist.label }"
          end
        end
      end
    end

    return nei_limiti
  end
end
