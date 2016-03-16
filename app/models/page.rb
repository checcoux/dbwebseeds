class Page < ActiveRecord::Base
  belongs_to :section
  has_many :rows, dependent: :destroy
end
