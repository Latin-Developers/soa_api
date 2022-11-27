# frozen_string_literal: true

require 'dry/transaction'

module UFeeling
  module Services
    # Transaction to store a video with comments from Youtube API to database
    class AddVideo
      include Dry::Transaction

      step :parse_url
      step :get_video
      step :add_video_to_db
      step :get_comments
      step :add_comments_to_db

      private

      def parse_url(input)
        if input.success?
          video_id = input[:video_url].split('=')[-1]
          Success(video_id:)
        else
          Failure("URL #{input.errors.messages.first}")
        end
      end

      # Get video from Youtube
      def get_video(input)
        if (video = video_in_database(input))
          input[:local_video] = video
        else
          input[:remote_video] = video_from_origin(input)
        end
        Success(input)
      rescue StandardError => e
        Failure(e.to_s)
      end

      def add_video_to_db(input)
        # Add video to database
        video = if (new_video = input[:remote_video])
                  UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Video).find_or_create(new_video)
                else
                  input[:local_video]
                end
        Success(video)
      rescue StandardError => e
        puts "@@Error : #{e}"
        Failure('Having trouble accessing the database')
      end

      # Get comments from Youtube (Julian added)
      # TODO: Verificar el paginado de los comentarios
      def get_comments(input)
        comments = UFeeling::Videos::Mappers::ApiComment
          .new(App.config.YOUTUBE_API_KEY)
          .comments(input[:origin_id])

        Success(comments)
        # ? Como vamos a manejar estas excepciones?
      rescue StandardError => e
        puts "@@Error : #{e}"
        Failure('There is a problem accesing the database')
      end

      # Add comments to database
      # TODO: Verificar actualizacion de comentarios. (Reprocesar el sentimiento?)
      def add_comments_to_db(_input)
        [:comments].each do |comment|
          UFeeling::Videos::Repository::For
            .klass(UFeeling::Videos::Entity::Comment)
            .find_or_create(comment)
        end
      end

      # Support methods that other services could use

      def video_from_origin(input)
        UFeeling::Videos::Mappers::ApiVideo
          .new(App.config.YOUTUBE_API_KEY).details(input[:video_id])
      rescue StandardError
        raise 'Could not find that video on Youtube'
      end

      def video_in_database(input)
        UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Video)
          .find(input[:video_id])
      end

      def comment_in_database(input)
        UFeeling::Videos::Repository::For.klass(UFeeling::Videos::Entity::Video)
          .find(input[:video_id])
      end
    end
  end
end
