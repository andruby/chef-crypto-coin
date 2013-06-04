# Example recipe that uses the LWRP to install bitcoind

include_recipe "crypto-coin::default"

crypto_coin "bitcoin" do
  repository "https://github.com/bitcoin/bitcoin.git"
  revision   "v0.8.2"
  port       8333
end