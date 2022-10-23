# frozen_string_literal: true

require_relative '../spec/spec_helper'
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require_relative '../lib/youtube_api'
require_relative '../lib/youtube_constants'
require_relative '../lib/http_utils/errors'

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

  describe 'Youtube categories information' do
    it 'HAPPY: should provide list of youtube video categories' do
      categories = YoutubeAnalytics::YoutubeAPI.new(YOUTUBE_API_KEY)
                                               .categories(YoutubeAnalytics::REGIONS[:GUATEMALA])
      _(categories.size).must_be :>, 0
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::YoutubeAPI.new('BAD_TOKEN')
        .categories(YoutubeAnalytics::REGIONS[:GUATEMALA])
      end).must_raise Errors::BadRequest
    end
  end

  describe 'Youtube videos information' do
    it 'HAPPY: should provide list of youtube videos' do
      videos = YoutubeAnalytics::YoutubeAPI.new(YOUTUBE_API_KEY)
                                           .popular_videos(YoutubeAnalytics::REGIONS[:GUATEMALA])
      _(videos.size).must_be :>, 0
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::YoutubeAPI.new('BAD_TOKEN')
                                              .popular_videos(YoutubeAnalytics::REGIONS[:GUATEMALA])
      end).must_raise Errors::BadRequest
    end
  end

  describe 'Youtube comments information' do
    it 'HAPPY: should provide list of youtube comments' do
      comments = YoutubeAnalytics::YoutubeAPI.new(YOUTUBE_API_KEY)
                                             .video_comments('ggGINmj5EQE')
      _(comments.size).must_be :>, 0
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::YoutubeAPI.new('BAD_TOKEN')
                                              .video_comments('ggGINmj5EQE')
      end).must_raise Errors::BadRequest
    end
  end

  describe 'Youtube detail video information' do
    it 'HAPPY: should provide list of youtube video detail' do
      details = YoutubeAnalytics::YoutubeAPI.new(YOUTUBE_API_KEY).video_details('ggGINmj5EQE')
      _(details.id).must_equal 'ggGINmj5EQE'
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::YoutubeAPI.new('BAD_TOKEN').video_details('ggGINmj5EQE')
      end).must_raise Errors::BadRequest
    end
  end
end
