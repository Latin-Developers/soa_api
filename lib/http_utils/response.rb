# frozen_string_literal: true

require_relative 'errors'

# Decorates HTTP responses from Github with success/error reporting
class Response < SimpleDelegator
  HTTP_ERROR = {
    400 => Errors::BadRequest,
    401 => Errors::Unauthorized,
    404 => Errors::NotFound
  }.freeze

  def successful?
    HTTP_ERROR.keys.none?(code)
  end

  def error
    HTTP_ERROR[code]
  end
end
