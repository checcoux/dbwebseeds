class Instance < ActiveRecord::Base
  belongs_to :entity
  belongs_to :section
  has_many :data, dependent: :destroy
end
