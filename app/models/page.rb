class Page < ActiveRecord::Base
  extend FriendlyId
  belongs_to :section
  has_many :rows, dependent: :destroy

  friendly_id :slug_candidates, :use => :slugged
  validates_presence_of :titolo, :slug

  def slug_candidates
    [
        [ section.percorso, :titolo ]
    ]
  end
end
