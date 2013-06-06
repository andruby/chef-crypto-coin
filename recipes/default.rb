#
# Cookbook Name:: crypto-coin
# Recipe:: default
#
# Copyright (C) 2013 Andrew Fecheyr
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#
# Include this recipe to get access to the crypto_coin LWRP

include_recipe "apt"

# Apt repository with BerkleyDB 4.8 packages
apt_repository "bitcoin" do
  uri "http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu"
  distribution "precise"
  components ["main"]
  deb_src true
  keyserver "keyserver.ubuntu.com"
  key "8842CE5E"
end

# Required packages
package "git-core"
package "libssl-dev"
package "libdb4.8-dev"
package "libdb4.8++-dev"
package "libboost1.48-all-dev"
