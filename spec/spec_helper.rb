require 'yaml'
require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/youtube_api_explorer'

USERNAME = 'avasquezni'
PROJECT_NAME = 'soa_api'
CONFIG = YAML.safe_load(File.read('config/secrets.yml')) #**
YOUTUBE_TOKEN = CONFIG['YOUTUBE_TOKEN'] #GITHUB_TOKEN = CONFIG['GITHUB_TOKEN']
CORRECT = YAML.safe_load(File.read('spec/fixtures/github_results.yml'))
CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'soa_api'