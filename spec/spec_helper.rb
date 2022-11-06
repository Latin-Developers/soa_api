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

YOUTUBE_API_KEY = YoutubeAnalytics::App.config.YOUTUBE_API_KEY

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'youtube_api'
