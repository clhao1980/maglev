# -*- ruby -*-
# This file is read by the maglev-irb shell script.
#
#   irb.rb - intaractive ruby
#     $Release Version: 0.9.5 $
#     $Revision: 11708 $
#     $Date: 2007-02-13 08:01:19 +0900 (Tue, 13 Feb 2007) $
#     by Keiju ISHITSUKA(keiju@ruby-lang.org)
#
$-I.unshift File.dirname($0)

def STDIN.tty?
  true
end

# MAGLEV_DEBUG_IRB = true # uncomment here and in irb.rb to debug

require "irb"

if __FILE__ == $0
  IRB.start(__FILE__)
else
  # check -e option
  if /^-e$/ =~ $0
    IRB.start(__FILE__)
  else
    IRB.setup(__FILE__)
  end
end
