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
                    :default_url => "img/missing.png"

  validates_attachment_size :immagine, :less_than => 3.megabytes
  validates_attachment_content_type :immagine, :content_type => /\Aimage/

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
    index_property = Property.where("entity_id = ? AND indice = ?", self.id, true).order(:ordine).first

    # if index_property && self.slug !~ /^[Ii]scrizione/
    if false # ATTENZIONE: a cosa serviva? disabilitato perché creava un problema se la index_property era di tipo utente
      # restituisce una collezione di istanze già collegate alla index property
      Instance.joins(:data).where("instances.entity_id = ? AND data.property_id = ?", self.id, index_property.id).order('data.valore ASC')
    else
      Instance.where("instances.entity_id = ?", self.id)
    end
  end
end
