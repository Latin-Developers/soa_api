# frozen_string_literal: true

require 'roda'
require 'slim'

module YoutubeAnalytics
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # GET /
      routing.root do
        view 'home'
      end

      # POST /videos/
      routing.on 'videos' do
        routing.is do
          # POST /videos/
          routing.post do
            region_code = routing.params['region_code'].uppercase

            routing.redirect "/videos/region/#{region_code}/video_category/"
          end
        end

        routing.on 'region' do
          # GET /videos/region

          routing.on String do |region_code|
            # GET /videos/
            routing.on 'video_category' do
              routing.get do
                categories = YoutubeAnalytics::Youtube::VideoCategoryMapper.new(YOUTUBE_API_KEY)
                                                                           .categories(region_code)

                view 'project', locals: { categories: }
              end
            end
          end
        end
      end
    end
  end
end
