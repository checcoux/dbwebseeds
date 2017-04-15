class Photoalbum < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged
  friendly_id :slug_candidates, :use => :slugged

  def slug_candidates
    [ :titolo, :titolo_e_sequenza ]
  end

  def titolo_e_sequenza
    slug = normalize_friendly_id(titolo)
    sequence = self.class.where("slug like '#{slug}-%'").count + 2
    "#{slug}-#{sequence}"
  end

  belongs_to :section

  has_many :photos, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy

  accepts_nested_attributes_for :photos

  self.per_page = 30

end