require 'net/http'
require 'json'
require 'digest'
require 'cgi'

module Cubepay
  class Signature

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def get_params_with_signature(params)
      params["client_id"] = @client_id
      params["sign"] = generate_signature(params)

      return params
    end

    def generate_signature(params)
      if !params['sign'].nil?
        params.delete('sign')
      end
      sort_params = params.sort_by { |key, value| key }
      string = CGI.unescape(URI.encode_www_form(sort_params) + "&client_secret=" + @client_secret)

      return Digest::SHA256.hexdigest(string).upcase
    end

    def verify_signature(params)
      client_sign = params["sign"]
      params.delete('sign')

      server_sign = generate_signature(params)

      return client_sign == server_sign

    end
  end
end