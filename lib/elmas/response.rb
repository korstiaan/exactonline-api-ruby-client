# frozen_string_literal: true

require File.expand_path("../parser", __FILE__)
require File.expand_path("../utils", __FILE__)

module Elmas
  class Response
    attr_accessor :status_code, :response
    attr_writer :body

    def initialize(response)
      @response = response
      raise_and_log_error if fail?
    end

    def success?
      @response.success?
    end

    def body
      @response.body
    end

    def parsed
      Parser.new(body)
    end

    def result
      Elmas::ResultSet.new(parsed)
    end

    def results
      Elmas::ResultSet.new(parsed)
    end

    def status
      @response.status
    end

    def fail?
      !success?
    end

    def error_message
      parsed.error_message
    end

    def log_error
      message = "An error occured, the response had status #{status}. The content of the error was: #{error_message}"
      Elmas.error(message)
    end

    private

    def raise_and_log_error
      log_error

      case @response.status
      when 400
        raise BadRequestException.new(@response, parsed)
      when 401
        raise UnauthorizedException.new(@response, parsed)
      when 403
        raise ForbiddenException.new(@response, parsed)
      when 404
        raise NotFoundException.new(@response, parsed)
      when 429
        raise TooManyRequestsException.new(@response, parsed)
      when 400..499
        raise ClientException.new(@response, parsed)
      when 500..599
        raise ServerException.new(@response, parsed)
      else
        raise ApiException.new(@response, parsed)
      end
    end
  end
end
