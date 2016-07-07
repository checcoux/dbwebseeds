class Column < ActiveRecord::Base
  belongs_to :row
  has_many :column_images, dependent: :destroy
end