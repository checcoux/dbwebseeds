class Instance < ActiveRecord::Base
  belongs_to :entity
  belongs_to :section
  belongs_to :user

  has_many :data, dependent: :destroy

  def label
    name_properties = Property.where("entity_id = ? AND indice = ?", self.entity.id, true).order(:ordine)

    if name_properties.count >= 1
      label = ''
      name_properties.each do |name_property|
        if name_property.tipo == 'select'
          datum = Datum.find_by instance_id: self.id, property_id: name_property.id
          instance = Instance.where("id = ?", datum.valore).first
          label+= "#{instance.label} " if instance
        elsif name_property.tipo == 'utente' && self.user
          label+= self.user.profilo.label
          label+= ' - ' + self.user.appartenenza if !self.user.appartenenza.empty?
        else
          datum = Datum.find_by instance_id: self.id, property_id: name_property.id
          label+= "#{datum.valore} " if datum
        end
      end
    end

    if label
      label.strip
    else
      "#{self.entity.titolo} #{self.id}"
    end
  end

  # label in formato array
  def alabel
    label = []

    name_properties = Property.where("entity_id = ? AND indice = ?", self.entity.id, true).order(:ordine)

    if name_properties.count >= 1
      name_properties.each do |name_property|
        if name_property.tipo == 'select'
          datum = Datum.find_by instance_id: self.id, property_id: name_property.id
          instance = Instance.where("id = ?", datum.valore).first
          if instance
            label << "#{instance.label}"
          else
            label << ''
          end
        elsif name_property.tipo == 'utente' && self.user
          buffer = self.user.profilo.label
          buffer+= ' - ' + self.user.appartenenza if !self.user.appartenenza.empty?
          label << buffer
        elsif name_property.tipo == 'check'
          datum = Datum.find_by instance_id: self.id, property_id: name_property.id
          if datum
            label << (datum.valore == '1' ? '<i class="fi-check"></i>'.html_safe : '')
          else
            label << ''
          end
        else
          datum = Datum.find_by instance_id: self.id, property_id: name_property.id
          if datum
            label << "#{datum.valore}"
          else
            label << ''
          end
        end
      end
    else
      label << "#{self.entity.titolo} #{self.id}"
    end

    label
  end

  self.per_page = 20
end
