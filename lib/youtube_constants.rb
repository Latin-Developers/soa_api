# frozen_string_literal: true

module YoutubeAnalytics
  REGIONS = { TAIWAN: 'TW', MEXICO: 'MX', GUATEMALA: 'GT', NICARAGUA: 'NI' }.freeze
  PATH_FILTERS = { SNIPPET: 'snippet', STATISTICS: 'statistics', CONTENT_DETAILS: 'contentDetails',
                   REPLIES: 'replies' }.freeze
  CHART_FILTERS = { MOST_POPULAR: 'mostPopular' }.freeze
end
