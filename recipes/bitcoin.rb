# Example recipe that uses the LWRP to install bitcoind

include_recipe "crypto-coin::default"

crypto_coin "bitcoin" do
  repository "https://github.com/bitcoin/bitcoin.git"
  # Needed to add ^{} to tag name to stop git from fetching the wrong sha
  revision  "v0.8.2^{}"
  port       8333
end