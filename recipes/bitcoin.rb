# Example recipe that uses the LWRP to install bitcoind

crypto_coin "bitcoin" do
  repository "https://github.com/bitcoin/bitcoin.git"
  revision   "0.8.1"
  port       8333
end