require 'net/https'
require 'json'
require 'openssl'

module Cubepay
  class HttpRequest

    def initialize(url)
      @url = url
    end

    def get_response(method, params)
      begin
        uri = URI.parse(@url + method)
        res = Net::HTTP.post_form(uri, params)
        result = JSON.parse(res.body)
      rescue SocketError, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse,
          Net::HTTPHeaderSyntaxError, Net::ProtocolError, OpenSSL::SSL::SSLError => e
        result = {"status" => 500, "data" => "#{e.class} - #{e.message}"}
      end

      return result
    end

  end
end
