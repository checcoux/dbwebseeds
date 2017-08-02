class Instance < ActiveRecord::Base
  belongs_to :entity
  belongs_to :section
end
