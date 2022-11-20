# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module UFeeling
  # Web App
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :all_verbs # allows HTTP verbs beyond GET/POST (e.g., DELETE)
    plugin :render, engine: 'slim', views: 'app/presentation/views_html'
    plugin :public, root: 'app/presentation/public'
    plugin :assets, path: 'app/presentation/assets', css: 'style.css'
    plugin :common_logger, $stderr

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'
      routing.public
      # [GET]   /                             Home
      # [POST]  /videos?url=                  Analyze a new video
      # [GET]   /videos/:video_id             Gets the analysis of a video
      # [GET]   /videos/:video_id/comments    Gets the analysis of a video including the list of top comments

      # [GET] /
      routing.root do
        # Get cookie viewer's previously seen videos
        session[:watching] ||= []

        # Load previously searched videos
        videos = UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Video)
          .find_ids(session[:watching])

        session[:watching] = videos.map(&:id)

        flash.now[:notice] = 'Search for a video to get started' if videos.none?

        viewed_videos = Views::VideoList.new(videos)
        view 'home', locals: { videos: viewed_videos }
      end

      # [...] /videos/
      routing.on 'videos' do
        # [POST]  /videos?url=
        routing.post do
          video_url = routing.params['video_url']
          routing.halt 400 unless (video_url.include? 'youtube.com') &&
                                  (video_url.include? 'watch?v=') &&
                                  (video_url.split('/').count >= 3)

          begin
            video_id = video_url.split('=')[-1]

            # Get video from Youtube
            video = UFeeling::Videos::Mappers::ApiVideo.new(App.config.YOUTUBE_API_KEY).details(video_id)

            # Add video to database
            video = UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Video).find_or_create(video)

            # Adding watched video to the current cookie session
            session[:watching].insert(0, video.id).uniq!
          rescue StandardError
            flash[:error] = 'Having trouble accessing the database'
          end

          # Redirect viewer to video page
          routing.redirect "videos/#{video.origin_id}"
        end

        # [...]  /videos/:video_origin_id
        routing.on String do |video_origin_id|
          # [GET]  /videos/:video_origin_id
          routing.is do
            routing.get do
              # Get Video from database
              begin
                video = UFeeling::Videos::Repository::For
                  .klass(UFeeling::Videos::Entity::Video)
                  .find_origin_id(video_origin_id)

                if video.nil?
                  flash[:error] = 'Could not find the requested video'
                  routing.redirect '/'
                end
              rescue StandardError
                flash[:error] = 'Having trouble accessing the database'
                routing.redirect '/'
              end

              # Show viewer the video
              view 'video', locals: { video: }
            end
          end

          # [...]  /videos/:video_origin_id/comments
          routing.on 'comments' do
            # [GET]  /videos/:video_origin_id/comments
            # routing.get {}
          end
        end
      end
    end
  end
end
