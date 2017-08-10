class Entity < ActiveRecord::Base
  extend FriendlyId

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
end
