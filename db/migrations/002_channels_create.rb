# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:channels) do
      primary_key :id
      String      :title
      String      :description
      String      :country # Confirmar valor
    end
  end
end
