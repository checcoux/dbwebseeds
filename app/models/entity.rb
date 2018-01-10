class Entity < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_many :properties, dependent: :destroy
  has_many :instances, dependent: :destroy

  friendly_id :slug_candidates, :use => :slugged

  has_attached_file :immagine,
                    :hash_secret => "hj42ZZ5!76",
                    :url  => "/img/entity/:hash.:extension",
                    :path => ":rails_root/public/img/entity/:hash.:extension",
                    :styles => {
                        :thumb => '400x250#',
                        :medium => '1024>',
                        :large => '1200>'
                    },
                    :convert_options => {
                        :thumb => "-quality 75 -strip",
                        :medium => "-quality 75 -strip",
                        :large => "-quality 75 -strip"
                    },
                    :default_url => "/img/missing.png"

  validates_attachment_size :immagine, :less_than => 3.megabytes
  validates_attachment_content_type :immagine, :content_type => /\Aimage/

  has_attached_file :icona_on,
                    :hash_secret => "hj42ZZ5!76",
                    :url  => "/img/entity/on/:hash.:extension",
                    :path => ":rails_root/public/img/entity/on/:hash.:extension",
                    :styles => {
                        :thumb => '256x256#',
                    },
                    :convert_options => {
                        :thumb => "-quality 75 -strip",
                    },
                    :default_url => "/img/entity/oggetto.png"

  validates_attachment_size :icona_on, :less_than => 3.megabytes
  validates_attachment_content_type :icona_on, :content_type => /\Aimage/

  has_attached_file :icona_off,
                    :hash_secret => "hj42ZZ5!76",
                    :url  => "/img/entity/off/:hash.:extension",
                    :path => ":rails_root/public/img/entity/off/:hash.:extension",
                    :styles => {
                        :thumb => '256x256#',
                    },
                    :convert_options => {
                        :thumb => "-quality 75 -strip",
                    },
                    :default_url => "/img/entity/oggetto_disabled.png"

  validates_attachment_size :icona_off, :less_than => 3.megabytes
  validates_attachment_content_type :icona_off, :content_type => /\Aimage/

  def slug_candidates
    [ :titolo, :titolo_e_sequenza ]
  end

  def titolo_e_sequenza
    slug = normalize_friendly_id(titolo)
    sequence = self.class.where("slug like '#{slug}-%'").count + 2
    "#{slug}-#{sequence}"
  end

  def label
    name_properties = Property.where("entity_id = ? AND indice = ? AND nome NOT LIKE 'limite'", self.id, true).order(:ordine)

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

  # label in formato array
  def alabel
    label = []

    name_properties = Property.where("entity_id = ? AND indice = ?", self.id, true).order(:ordine)

    if name_properties.count >= 1
      name_properties.each do |name_property|
        label << "#{name_property.nome} "
      end
    else
      label << "#{self.titolo} n."
    end

    label
  end

  def elenco
    # al momento ordiniamo unicamente in base alla prima index property
    index_property = Property.where("entity_id = ? AND indice = ? AND tipo NOT IN ('select','utente')", self.id, true).order(:ordine).first

    # if index_property && self.slug !~ /^[Ii]scrizione/
    # if false # ATTENZIONE: crea un problema se la index_property è di tipo utente
    if index_property
      # restituisce una collezione di istanze già collegate alla index property, e ordinate in base a questa
      Instance.joins(:data).where("instances.entity_id = ? AND data.property_id = ?", self.id, index_property.id).order('data.valore ASC')
    else
      Instance.where("instances.entity_id = ?", self.id)
    end
  end

  #def cerca_per_appartenenza
    # Instance.joins(:data).where("instances.entity_id = ? AND data.property_id = ?", self.id, index_property.id).order('data.valore ASC')
    # Instance.joins(:user).joins().where("instances.entity_id = ? AND data.property_id = ?", self.id, index_property.id).order('data.valore ASC')
    # nota: non potrebbe funzionare
  #end
end
