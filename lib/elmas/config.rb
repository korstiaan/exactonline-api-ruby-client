require 'faraday'

module Elmas
  module Config
    # An array of valid keys in the options hash
    VALID_OPTIONS_KEYS = [
      :access_token,
      :adapter,
      :client_id,
      :client_secret,
      :connection_options,
      :redirect_uri,
      :response_format,
      :user_agent,
      :endpoint
    ].freeze

    # By default, don't set a user access token
    DEFAULT_ACCESS_TOKEN = nil

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, client id should be set in .env
    DEFAULT_CLIENT_ID = nil

    # By default, client secret should be set in .env
    DEFAULT_CLIENT_SECRET = nil

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = 'https://start.exactonline.nl/api/v1/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    DEFAULT_FORMAT = :json

    # By default, don't set an application redirect uri
    DEFAULT_REDIRECT_URI = nil

    # By default, don't set user agent
    DEFAULT_USER_AGENT = nil

    # An array of valid request/response formats
    VALID_FORMATS = [:json].freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.access_token       = DEFAULT_ACCESS_TOKEN
      self.adapter            = DEFAULT_ADAPTER
      self.client_id          = DEFAULT_CLIENT_ID
      self.client_secret      = DEFAULT_CLIENT_SECRET
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.redirect_uri       = DEFAULT_REDIRECT_URI
      self.response_format    = DEFAULT_FORMAT
      self.user_agent         = DEFAULT_USER_AGENT
    end
  end
end
