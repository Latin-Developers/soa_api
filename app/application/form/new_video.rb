# frozen_string_literal: true

require 'dry-validation'

module UFeeling
  module Forms
    # Youtube URL Validation
    class NewVideo < Dry::Validation::Contract
      URL_REGEX =
        %r{^((?:https?:)?//)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(/(?:[\w-]+\?v=|embed/|v/)?)([\w-]+)(\S+)?$}

      params do
        required(:video_url).filled(:string)
      end

      rule(:video_url) do
        key.failure('This is not a valid Youtube URL') unless URL_REGEX.match?(value)
      end
    end
  end
end
