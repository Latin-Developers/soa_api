# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    YoutubeAnalytics::App.DB.run('PRAGMA foreign_keys = OFF')
    YoutubeAnalytics::Database::MemberOrm.map(&:destroy)
    YoutubeAnalytics::Database::ProjectOrm.map(&:destroy)
    YoutubeAnalytics::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
