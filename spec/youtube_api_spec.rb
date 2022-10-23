# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require_relative '../spec/spec_helper'
require_relative '../lib/youtube_api'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
YOUTUBE_API_KEY = CONFIG['YOUTUBE_API_KEY']

describe 'Tests Youtube API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<YOUTUBE_API_KEY>') { YOUTUBE_API_KEY }
    c.filter_sensitive_data('<YOUTUBE_API_KEY_ESC>') { CGI.escape(YOUTUBE_API_KEY) }
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

    describe 'Youtube comments information' do
      it 'HAPPY: should provide list of youtube comments' do
        comments = YoutubeAnalytics::YoutubeApi.new(YOUTUBE_API_KEY).comments
        _(comments.size).must_be :>, 0
      end

      it 'SAD: should raise exception when unauthorized' do
        _(proc do
          YoutubeAnalytics::YoutubeApi.new('BAD_TOKEN').comments
        end).must_raise YoutubeAnalytics::YoutubeApi::Errors::BadRequest
      end
    end

    describe 'Youtube detail video information' do
      it 'HAPPY: should provide list of youtube video detail' do
        details = YoutubeAnalytics::YoutubeApi.new(YOUTUBE_API_KEY).details
        _(details.id).must_equal 'ggGINmj5EQE'
      end

      it 'SAD: should raise exception when unauthorized' do
        _(proc do
          YoutubeAnalytics::YoutubeApi.new('BAD_TOKEN').details
        end).must_raise YoutubeAnalytics::YoutubeApi::Errors::BadRequest
      end
    end
  end
end
