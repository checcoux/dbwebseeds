# collection di photos

class Photoalbum < ActiveRecord::Base

  extend FriendlyId
  # friendly_id :name, use: :slugged
  friendly_id :slug_candidates, :use => :slugged

  def slug_candidates
    [ :titolo, :titolo_e_sequenza ]
  end

  def titolo_e_sequenza
    slug = normalize_friendly_id(titolo)
    sequence = self.class.where("slug like '#{slug}-%'").count + 2
    "#{slug}-#{sequence}"
  end

  def trova_immagine_social
    # se esiste seleziona un'immagine per i social
    photo = Photo.find_by(id: copertina)
    if photo
      geometry = Paperclip::Geometry.from_file(photo.immagine.file)
      {:url => photo.immagine.url(:xlarge), :width => geometry.width.to_i, :height => geometry.height.to_i }
    end
  end

  belongs_to :section

  has_many :photos, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :news, :class_name => 'Column', as: :columnable, dependent: :destroy

  accepts_nested_attributes_for :photos

  self.per_page = 30

end
