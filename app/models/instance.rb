class Instance < ActiveRecord::Base
  belongs_to :entity
  belongs_to :section
  belongs_to :user

  has_many :data, dependent: :destroy

  def label
    name_properties = Property.where("entity_id = ? AND indice = ?", self.entity.id, true)

    if name_properties.count >= 1
      label = ''
      name_properties.each do |name_property|
        datum = Datum.find_by instance_id: self.id, property_id: name_property.id
        label+= "#{datum.valore} " if datum
      end
    end

    if label
      label.strip
    else
      "#{self.entity.titolo} #{self.id}"
    end
  end
end
