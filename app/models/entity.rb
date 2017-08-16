class Entity < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_many :properties, dependent: :destroy
  has_many :instances, dependent: :destroy

  friendly_id :slug_candidates, :use => :slugged

  def slug_candidates
    [ :titolo, :titolo_e_sequenza ]
  end

  def titolo_e_sequenza
    slug = normalize_friendly_id(titolo)
    sequence = self.class.where("slug like '#{slug}-%'").count + 2
    "#{slug}-#{sequence}"
  end

  def label
    name_properties = Property.where("entity_id = ? AND indice = ?", self.id, true).order(:ordine)

    if name_properties.count >= 1
      label = ''
      name_properties.each do |name_property|
        label+= "#{name_property.nome} "
      end
    end

    if label
      label.strip
    else
      "#{self.titolo} n."
    end
  end

  def elenco
    # al momento ordiniamo unicamente in base alla prima index property
    index_property = Property.where("entity_id = ? AND indice = ?", self.id, true).first

    if index_property
      # restituisce una collezione di istanze già collegate alla index property
      Instance.joins(:data).where("instances.entity_id = ? AND data.property_id = ?", self.id, index_property.id).order('data.valore ASC')
    else
      # se non è definita una index property ordiniamo in base alla prima property disponibile, se non ne esiste una solleviamo un'eccezione
      # index_property = Property.find_by! entity_id: self.id if !index_property
      Instance.where("instances.entity_id = ?", self.id)
    end
  end
end
