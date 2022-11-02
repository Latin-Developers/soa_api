# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:channels) do
      primary_key :key

      String      :id
      String      :title
      String      :description
      String      :country

    end
  end
end