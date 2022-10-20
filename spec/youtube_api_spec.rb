# frozen_string_literal: true

require_relative 'spec_helper'
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/youtube_api'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
YOUTUBE_API_KEY = CONFIG['YOUTUBE_API_KEY']
# CORRECT = YAML.safe_load(File.read('spec/fixtures/github_results.yml'))

describe 'Tests Youtube API library' do
  VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock
    
    c.filter_sensitive_data('<YOUTUBE_TOKEN>') { YOUTUBE_TOKEN }
  c.filter_sensitive_data('<YOUTUBE_TOKEN_ESC>') { CGI.escape(YOUTUBE_TOKEN) }
  end
  
  before do
  VCR.insert_cassette CASSETTE_FILE,
  record: :new_episodes,
  match_requests_on: %i[method uri headers]
    end
  after do
  VCR.eject_cassette
  end

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

    describe 'Youtube videos information' do
      it 'HAPPY: should provide list of youtube videos' do
        videos = YoutubeAnalytics::YoutubeApi.new(YOUTUBE_API_KEY).videos
        _(videos.size).must_be :>, 0
      end

      it 'SAD: should raise exception when unauthorized' do
        _(proc do
          YoutubeAnalytics::YoutubeApi.new('BAD_TOKEN').videos
        end).must_raise YoutubeAnalytics::YoutubeApi::Errors::BadRequest
      end
    end

  end

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock
  [...]
  end
    
    before do
  VCR.insert_cassette CASSETTE_FILE,
  record: :new_episodes,
  match_requests_on: %i[method uri headers]
  end
    
    after do
  VCR.eject_cassette
  end
