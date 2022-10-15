# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/youtube_api'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
YOUTUBE_API_KEY = CONFIG['YOUTUBE_API_KEY']
# CORRECT = YAML.safe_load(File.read('spec/fixtures/github_results.yml'))

describe 'Tests Youtube API library' do
  describe 'Youtube categories information' do
    it 'HAPPY: should provide list of youtube video categories' do
      categories = YoutubeAnalytics::YoutubeApi.new(YOUTUBE_API_KEY).categories
      _(categories.size).must_be :>, 0
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::YoutubeApi.new('BAD_TOKEN').categories
      end).must_raise YoutubeAnalytics::YoutubeApi::Errors::BadRequest
    end
  end
end
