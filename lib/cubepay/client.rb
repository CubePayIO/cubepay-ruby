require_relative 'http_request'
require_relative 'signature'

module Cubepay
  class Client
    attr_accessor(
        :client_id,
        :client_secret,
        :url
    )
    attr_reader(
        :http_request,
        :signature
    )

    def initialize(client_id, client_secret, url)
      @http_request = HttpRequest.new(url)
      @signature = Signature.new(client_id, client_secret)
    end

    # Get list of available cryptocurrencies.
    # You can use these currencies at payment API for receive/send coin.
    def get_coin
      method = "/currency/coin"
      params = {}

      sign_params = self.signature.get_params_with_signature(params)
      response = self.http_request.get_response(method, sign_params)

      return response
    end

    # Get list of available fiat currenies.
    # You can only use these fiat currencies for your product's original list price, not for receive/send,
    # we'll convert value by exchange rate between currency of list price and currency of actual paid.
    def get_fiat
      method = "/currency/fiat"
      params = {}

      sign_params = self.signature.get_params_with_signature(params)
      response = self.http_request.get_response(method, sign_params)

      return response
    end

    # Render a page(but not initial a payment yet) within these information:
    # - Your shop information
    # - Item name
    # - Payable coin list and corresponding price.
    def do_payment(source_coin_id, source_amount, item_name, merchant_transaction_id, other = "", return_url = "",
                   ipn_url = "", send_coin_id = "", send_amount = "", receive_address = "")
      method = "/payment"
      params = {
          "source_coin_id" => source_coin_id,
          "source_amount" => source_amount,
          "item_name" => item_name,
          "merchant_transaction_id" => merchant_transaction_id,
          "other" => other,
          "return_url" => return_url,
          "ipn_url" => ipn_url,
          "send_coin_id" => send_coin_id,
          "send_amount" => send_amount,
          "receive_address" => receive_address,
      }

      sign_params = self.signature.get_params_with_signature(params)
      response = self.http_request.get_response(method, sign_params)

      return response
    end

    # Initial order with specific coin. Order will expire after 6 hours.
    # If you define the parameter send_coin_id, receive_address, send_amount to send back coin to your customer,
    # we'll lock the amount of send coin and fee temporarily and unlock until payment finish or expired.
    def do_payment_by_coin_id(coin_id, source_coin_id, source_amount, item_name, merchant_transaction_id, other = "", return_url = "",
                              ipn_url = "", send_coin_id = "", send_amount = "", receive_address = "")
      method = "/payment/coin"
      params = {
          "coin_id" => coin_id,
          "source_coin_id" => source_coin_id,
          "source_amount" => source_amount,
          "item_name" => item_name,
          "merchant_transaction_id" => merchant_transaction_id,
          "other" => other,
          "return_url" => return_url,
          "ipn_url" => ipn_url,
          "send_coin_id" => send_coin_id,
          "send_amount" => send_amount,
          "receive_address" => receive_address,
      }

      sign_params = self.signature.get_params_with_signature(params)
      response = self.http_request.get_response(method, sign_params)

      return response
    end

    # Query payment information by specific identity.
    def query_payment(cubepay_transaction_id = "", merchant_transaction_id = "")
      method = "/payment/query"
      params = {
          "id" => cubepay_transaction_id,
          "merchant_transaction_id" => merchant_transaction_id,
      }

      sign_params = self.signature.get_params_with_signature(params)
      response = self.http_request.get_response(method, sign_params)

      return response
    end

  end
end