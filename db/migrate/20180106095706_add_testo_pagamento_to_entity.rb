class AddTestoPagamentoToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :testo_pagamento, :text
    add_column :entities, :applica_limiti_appartenenza, :boolean, default: false
  end
end
