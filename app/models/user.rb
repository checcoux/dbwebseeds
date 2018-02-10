# utente

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :section

  has_many :entities, dependent: :nullify
  has_many :instances, dependent: :nullify

  self.per_page = 15

  def profilo
    # attenzione: un'entity di tipo profilo deve essere definita

    section_id = Section.find_by(principale: true)

    entity_a = Entity.find_by! slug: 'profilo'

    profilo = Instance.find_by entity_id: entity_a.id, user_id: self.id

    if profilo
      # restituisce il profilo
      profilo
    else
      # crea un nuovo profilo vuoto
      Instance.create entity_id: entity_a.id, user_id: self.id, section_id: section_id, appartenenza_id: 0, proxy: ''
    end
  end

  # se è definita l'appartenenza nel profilo dell'utente, la restituisce
  def appartenenza
    entity_profilo = Entity.find_by! slug: 'profilo'
    entity_appartenenza = Entity.find_by! slug: 'appartenenza'

    return '' if !entity_profilo or !entity_appartenenza

    property_appartenenza = entity_profilo.properties.find_by tipo: 'select', condizioni: 'appartenenza,all'

    profilo = Instance.find_by entity_id: entity_profilo.id, user_id: self.id

    return '' if !profilo or !property_appartenenza

    datum_appartenenza = profilo.data.find_by property_id: property_appartenenza.id

    return '' if !datum_appartenenza

    appartenenza_id = datum_appartenenza.valore.to_i

    appartenenza = entity_appartenenza.instances.where(id: appartenenza_id).first
    # nota: non si può semplificare in Instance.find(instance.user.appartenenza_id) perché nel caso non esistesse solleverebbe un'eccezione

    if appartenenza
      appartenenza.label
    else
      ''
    end
  end

  # se è definita l'appartenenza nel profilo dell'utente, la restituisce
  def appartenenza_id
    entity_profilo = Entity.find_by! slug: 'profilo'
    entity_appartenenza = Entity.find_by! slug: 'appartenenza'

    return 0 if !entity_profilo or !entity_appartenenza

    property_appartenenza = entity_profilo.properties.find_by tipo: 'select', condizioni: 'appartenenza,all'

    profilo = Instance.find_by entity_id: entity_profilo.id, user_id: self.id

    return 0 if !profilo or !property_appartenenza

    datum_appartenenza = profilo.data.find_by property_id: property_appartenenza.id

    return 0 if !datum_appartenenza

    datum_appartenenza.valore.to_i
  end
end
