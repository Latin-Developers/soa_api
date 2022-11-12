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
          video_url = routing.params['video_url']
          routing.halt 400 unless (video_url.include? 'youtube.com') &&
                                  (video_url.include? 'watch?v=') &&
                                  (video_url.split('/').count >= 3)
          video_id = video_url.split('=')[-1]

          # Get video from Youtube
          video = UFeeling::Videos::Mappers::ApiVideo.new(App.config.YOUTUBE_API_KEY).details(video_id)
          
          # Add video to database
          UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Video).find_or_create(video)

          # Redirect viewer to project page
          routing.redirect "videos/#{video.origin_id}"
        end

        # [...]  /videos/:video_origin_id
        routing.on String do |video_origin_id|
          # [GET]  /videos/:video_origin_id
          routing.is do
            routing.get do
              # Get Video from database
              video = UFeeling::Videos::Repository::For
                .klass(UFeeling::Videos::Entity::Video)
                .find_origin_id(video_origin_id)

                puts video:

              # Show viewer the video
              view 'video', locals: { video: video }
            end
          end

          # [...]  /videos/:video_origin_id/comments
          routing.on 'comments' do
            # [GET]  /videos/:video_origin_id/comments
            routing.get do
            end
          end
        end
      end
    end
  end
end
