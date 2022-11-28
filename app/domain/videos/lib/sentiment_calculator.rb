# frozen_string_literal: true

require 'vader_sentiment_ruby'

module UFeeling
  module Videos
    module Mixins
      # Snetiment calculator mixin
      module SentimentCalculator
        def calculate
          VaderSentimentRuby.polarity_scores(text)
        end
      end
    end
  end
end
