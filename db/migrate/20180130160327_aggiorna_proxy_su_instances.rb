class AggiornaProxySuInstances < ActiveRecord::Migration
  def self.up
    say_with_time "Aggiornamento dei proxy sulle Instances..." do
      Instance.all.each do |instance|
        instance.update_attribute :proxy, instance.label
      end
    end
  end

  def self.down
  end
end
