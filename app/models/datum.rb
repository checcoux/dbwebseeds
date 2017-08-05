class Datum < ActiveRecord::Base
  belongs_to :instance
  belongs_to :property
end
