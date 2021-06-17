# frozen_string_literal: true

module Elmas
  class BaseException < StandardError
    def initialize(response, parsed)
      @response = response
      @parsed = parsed
      super(message)
    end

    def message
      if @parsed.error_message.present?
        "code #{@response.status}: #{@parsed.error_message}"
      else
        @response.inspect
      end
    end
  end

  class BadRequestException < BaseException; end
  class NotFoundException < BaseException; end
  class ClientException < BaseException; end
  class ServerException < BaseException; end
  class TooManyRequestsException < BaseException; end
  class UnauthorizedException < BaseException; end
  class ForbiddenException < BaseException; end
  class ApiException < BaseException; end
end
