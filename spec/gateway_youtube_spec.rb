# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'

describe 'Tests Youtube API library' do
  before do
    VcrHelper.configure_vcr_for_youtube
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Youtube categories information' do
    it 'HAPPY: should provide list of youtube video categories' do
      categories = YoutubeAnalytics::Youtube::CategoryMapper.new(YOUTUBE_API_KEY)
                                                            .categories(YoutubeAnalytics::REGIONS[:GUATEMALA])
      _(categories.size).must_be :>, 0
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::Youtube::CategoryMapper.new('BAD_TOKEN')
        .categories(YoutubeAnalytics::REGIONS[:GUATEMALA])
      end).must_raise Errors::BadRequest
    end
  end

  describe 'Youtube videos information' do
    it 'HAPPY: should provide list of youtube videos' do
      videos = YoutubeAnalytics::Youtube::VideoMapper.new(YOUTUBE_API_KEY)
                                                     .popular_videos(YoutubeAnalytics::REGIONS[:GUATEMALA])
      _(videos.size).must_be :>, 0
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::Youtube::VideoMapper.new('BAD_TOKEN')
                                              .popular_videos(YoutubeAnalytics::REGIONS[:GUATEMALA])
      end).must_raise Errors::BadRequest
    end
  end

  describe 'Youtube comments information' do
    it 'HAPPY: should provide list of youtube comments' do
      comments = YoutubeAnalytics::Youtube::CommentMapper.new(YOUTUBE_API_KEY)
                                                         .comments('ggGINmj5EQE')
      _(comments.size).must_be :>, 0
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::Youtube::CommentMapper.new('BAD_TOKEN')
                                                     .comments('ggGINmj5EQE')
      end).must_raise Errors::BadRequest
    end
  end

  describe 'Youtube detail video information' do
    it 'HAPPY: should provide list of youtube video detail' do
      details = YoutubeAnalytics::Youtube::VideoMapper.new(YOUTUBE_API_KEY).details('ggGINmj5EQE')
      _(details.origin_id).must_equal 'ggGINmj5EQE'
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        YoutubeAnalytics::Youtube::VideoMapper.new('BAD_TOKEN').details('ggGINmj5EQE')
      end).must_raise Errors::BadRequest
    end
  end
end
