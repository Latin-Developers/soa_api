# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    UFeeling::App.DB.run('PRAGMA foreign_keys = OFF')
    UFeeling::Database::CategoryOrm.map(&:destroy)
    # UFeeling::Database::ProjectOrm.map(&:destroy)
    UFeeling::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
