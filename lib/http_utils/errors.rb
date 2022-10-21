# frozen_string_literal: true

module Errors
  # Handles api errors produced whenever an external resources replies with an 404
  class NotFound < StandardError; end
  # Handles api errors produced whenever an external resources replies with an 400
  class BadRequest < StandardError; end
  # Handles api errors produced whenever an external resources replies with an 401
  class Unauthorized < StandardError; end
end
