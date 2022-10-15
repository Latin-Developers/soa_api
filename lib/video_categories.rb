# frozen_string_literal: true

require 'http'
require 'yaml'

YOUTUBE_API_PATH = { VIDEO_CATEGORIES: 'videoCategories', VIDEOS: "videos" }.freeze

REGIONS = { TAIWAN: 'TW' }.freeze

YOUTUBE_API_KEY = 'YOUTUBE_API_KEY'
YOUTUBE_API = 'YOUTUBE_API'

config = YAML.safe_load(File.read('config/secrets.yml'))

def produce_youtube_api_path(config, path, args = {})
  api_base_url = config[YOUTUBE_API]
  api_key = config[YOUTUBE_API_KEY]
  query_fields = args.reduce('') { |previous, (key, value)| "#{previous}&#{key}=#{value}" }
  "#{api_base_url}/#{path}?key=#{api_key}#{query_fields}"
end

def call_youtube_api(url)
  HTTP.get(url)
end

categories_url = produce_youtube_api_path(config, YOUTUBE_API_PATH[:VIDEO_CATEGORIES], { regionCode: REGIONS[:TAIWAN] })
youtube_response = call_youtube_api(categories_url).parse

File.write('spec/fixtures/youtube_categories_results.yml', youtube_response.to_yaml)

categories_url = produce_youtube_api_path(config, YOUTUBE_API_PATH[:VIDEOS], { regionCode: REGIONS[:TAIWAN], part: 'snippet', chart: 'mostPopular'})
youtube_response = call_youtube_api(categories_url).parse

File.write('spec/fixtures/youtube_videos_results.yml', youtube_response.to_yaml)