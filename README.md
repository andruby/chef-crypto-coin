# crypto-coin cookbook

This cookbook provides a LWRP to compile bitcoin based crypto coins.

# Requirements

Requires build-essential. Eg from [this cookbook](https://github.com/opscode-cookbooks/build-essential).

# Usage

Example recipe for litecoin:

```ruby
# Get access to the LWRP and install prerequisites
include_recipe "crypto-coin::default"

# Download, compile and configure the cryptocoin
crypto_coin "litecoin" do
  repository    "https://github.com/litecoin-project/litecoin.git"
  revision      "0.6.3"
  port          9333
  rpcpassword   "nojxxq2rryghg1p0ti7x"
end

# Start the cryptocoin node
service "litecoind" do
  provider Chef::Provider::Service::Upstart
  action :start
end
```

# Recipes

## crypto-coin::default

Install prerequisites

## crypto-coin::bitcoin

Example recipe that compiles bitcoind and starts the node

## crypto-coin::litecoin

Example recipe that compiles litecoind and starts the node

# Author

Author:: Andrew Fecheyr (<andrew@bedesign.be>)
