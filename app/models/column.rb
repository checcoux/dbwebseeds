class Column < ActiveRecord::Base
  belongs_to :row
  has_many :column_image, dependent: :destroy
end