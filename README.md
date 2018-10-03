# CubePay API library for Ruby 
A third-party cryptocurrency payment gateway. 

Make it easy for receiving cryptocurrency!

More information at https://cubepay.io.


## API Document

https://document.cubepay.io

## Installation

    gem install cubepay


## Usage
**Initialization**
```
require 'cubepay'

client = Cubepay::Client.new(CLIENT_ID,CLIENT_SECRET,URL)
```

**Get available cryptocurrencies**

You can use these currencies at payment API for receive/send coin.

```
response = client.get_coin
```

**Get available fiat currenies.**

You can only use these fiat currencies for your product's original list price. We'll convert value by exchange rate between currency of list price and currency of actual paid.

```
response = client.get_fiat
```

**Do Payment**

Render a page with these payment information:
 - Your shop information
 - Item name
 - Payable coin list and corresponding price.
     
```
response = client.do_payment(source_coin_id, source_amount, item_name, merchant_transaction_id, other, return_url, ipn_url, send_coin_id, send_amount, receive_address)
```

**Init payment With specific coin**

Initial payment with specific coin. The payment will expire after 6 hours.
     
```
response = client.do_payment_by_coin_id(coin_id, source_coin_id, source_amount, item_name, merchant_transaction_id, other, return_url, ipn_url, send_coin_id, send_amount, receive_address)
```

**Query payment information**

Query payment information by specific identity
     
```
response = client.query_payment(cubepay_transaction_id, merchant_transaction_id)
```
