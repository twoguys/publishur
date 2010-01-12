require 'rubygems'
require 'net/toc'

# "aimbot99" needs to be a real AIM username, get one at aim.aol.com
Net::TOC.new("davemitre", "hockey83") do |msg, buddy|
  buddy.send_im("You said: #{msg}")
end