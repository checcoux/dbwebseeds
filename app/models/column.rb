class Column < ActiveRecord::Base
  belongs_to :row

  default_scope { order('ordine ASC') }
end