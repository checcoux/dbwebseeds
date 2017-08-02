class Entity < ActiveRecord::Base
  has_many :properties, dependent: :destroy
  has_many :instances, dependent: :destroy
end
