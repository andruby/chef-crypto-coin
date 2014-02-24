# Example recipe that uses the LWRP to install namecoind

# Get access to the LWRP and install prerequisites
include_recipe "crypto-coin::default"

# Requires extra package to prevent missing -lgthread-2.0 error
package "libglibmm-2.4-dev"

# Download, compile and configure the cryptocoin
crypto_coin "namecoin" do
  repository    "https://github.com/namecoin/namecoin.git"
  revision      "vQ.3.72"
  port          9333
  rpcpassword   "jrc6h78g5oB1t6A"
end

# Start the cryptocoin node
service "namecoind" do
  provider Chef::Provider::Service::Upstart
  action :start
end
