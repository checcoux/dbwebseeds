class Column < ActiveRecord::Base
  belongs_to :row
  belongs_to :page
  has_many :column_images, dependent: :destroy
end