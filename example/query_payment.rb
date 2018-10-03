require './_config'

client = Cubepay::Client.new(CLIENT_ID, CLIENT_SECRET, URL);

# CubePay payment ID
cubepay_transaction_id = "C1538368710528143362"
# Transaction ID generated by your shop.If your transaction is not unique, it'll return the last one record.
merchant_transaction_id = ""

result = client.query_payment(cubepay_transaction_id, merchant_transaction_id)
print result