class Property < ActiveRecord::Base
  belongs_to :entity
  has_many :data, dependent: :destroy
end
