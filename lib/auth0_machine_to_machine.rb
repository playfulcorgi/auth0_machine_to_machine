# Based on https://auth0.com/docs/quickstart/backend/rails/02-using.

require 'auth0_machine_to_machine/version'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'

module Auth0MachineToMachine
  class Auth0BearerTokenError < StandardError; end

  class GenericError < Auth0BearerTokenError; end

  class Client
    def getM2M!(config)
      tenant_name = config['tenant_name']
      client_id = config['client_id']
      client_secret = config['client_secret']
      audience = config['audience']
      grant_type = config['grant_type']

      url = URI("https://#{tenant_name}.eu.auth0.com/oauth/token")

      http = Net::HTTP.new(url.host, url.port)
      use_ssl = url.scheme == 'https'
      http.use_ssl = use_ssl
      if use_ssl
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      else
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request["accept"] = 'application/json'

      body = {
        client_id: client_id,
        client_secret: client_secret,
        audience: audience,
        grant_type: grant_type
      }

      request.body = body.to_json

      response = http.request(request)

      if response.is_a?(Net::HTTPSuccess)
        body = JSON.parse(response.body)
        expires_in = body['expires_in']
        expire_date = Time.now + expires_in
        result = {
          access_token: body['access_token'],
          scope: body['scope'],
          expires_in: expires_in,
          expire_date: expire_date,
          token_type: body['token_type']
        }
      else
        raise GenericError.new(response.code + response.body + response.message)
      end
    end

    def getM2M(config)
      begin
        getM2M!(config)
      rescue Exception => e
        false
      end
    end
  end
end