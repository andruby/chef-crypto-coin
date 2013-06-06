# Example recipe that uses the LWRP to install bitcoind

# Get access to the LWRP and install prerequisites
include_recipe "crypto-coin::default"

# Download, compile and configure the cryptocoin
crypto_coin "bitcoin" do
  repository    "https://github.com/bitcoin/bitcoin.git"
  # Needed to add ^{} to tag name to stop git from fetching the wrong sha
  revision      "v0.8.2^{}"
  port          8333
  rpcpassword   "z577bq0otos115isrf31"
end

# Start the cryptocoin node
service "bitcoind" do
  provider Chef::Provider::Service::Upstart
  action :start
end
