# frozen_string_literal: true

require 'roda'
require 'yaml'

module YoutubeAnalytics
  # Configuration for the App
  class App < Roda
    CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
    YOUTUBE_API_KEY = CONFIG['YOUTUBE_API_KEY']
  end
end
