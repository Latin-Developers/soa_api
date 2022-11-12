# frozen_string_literal: true

require 'roda'
require 'slim'

module UFeeling
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # [GET]   /                             Home
      # [POST]  /videos?url=                  Analyze a new video
      # [GET]   /videos/:video_id             Gets the analysis of a video
      # [GET]   /videos/:video_id/comments    Gets the analysis of a video including the list of top comments

      # [GET] /
      routing.root do
        view 'home'
      end

      # [...] /videos/
      routing.on 'videos' do
        # [POST]  /videos?url=
        routing.post do
        end

        # [...]  /videos/:video_id
        routing.on String do |video_id|
          # [GET]  /videos/:video_id
          routing.get do
            # [...]  /videos/:video_id/comments
            routing.on 'comments' do
              # [GET]  /videos/:video_id/comments
              routing.get do
              end
            end
          end
        end
      end
    end
  end
end
