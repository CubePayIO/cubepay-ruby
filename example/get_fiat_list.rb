require './_config'

client = Cubepay::Client.new(CLIENT_ID,CLIENT_SECRET,URL);

result = client.get_fiat
print result
