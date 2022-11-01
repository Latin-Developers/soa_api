# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'
require 'pry'

require_relative '../require_app'
require_app

USERNAME = 'latin'
PROJECT_NAME = 'Youtube-app'
YOUTUBE_API_KEY = YoutubeAnalytics::App.config.YOUTUBE_API_KEY
CORRECT = YAML.safe_load(File.read('spec/fixtures/youtube_comments.yml'))

#CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
#YOUTUBE_API_KEY = CONFIG['YOUTUBE_API_KEY']

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'youtube_api'
