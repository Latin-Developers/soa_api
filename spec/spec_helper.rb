# frozen_string_literal: true

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/youtube_api_explorer'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
YOUTUBE_API_KEY = CONFIG['YOUTUBE_API_KEY']
CORRECT = YAML.safe_load(File.read('spec/fixtures/youtube_results.yml'))
CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'youtube_api'
