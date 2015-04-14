module Elmas
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={})
      request(:get, path)
    end

    # Perform an HTTP POST request
    def post(path, options={})
      request(:post, path)
    end

    # Perform an HTTP PUT request
    def put(path, options={})
      request(:put, path, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={})
      request(:delete, path)
    end

    private

    # Perform an HTTP request
    def request(method, path, options)
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
      end
      return Response.create(response.body)
    end
  end
end
