# Some tests that ensure MagLev does correct stuff when invoked in various ways
#
require File.expand_path('simple', File.dirname(__FILE__))

# this is so we can run this file with either MRI or MagLev
A_OUT = defined?(RUBY_ENGINE) ? 'maglev-ruby' : 'ruby'
ENV['MAGLEV_OPTS'] = ''  # Ensure -MtraceLoad doesn't mess us up

# ############################################################
# Ensure __FILE__ is correct
# ############################################################
Struct.new("TC", :pwd, :prefix, :result) do
  def to_s
    "#{pwd} => #{prefix}"
  end
end

here = Dir.pwd + '/src/test'
test_cases =  [
  Struct::TC.new(Dir.pwd, "./src/test/lib/", "./src/test/lib/echo__FILE__.rb\n"),
  Struct::TC.new(here + '/lib', "", "echo__FILE__.rb\n"),
  Struct::TC.new(here + '/lib', "./", "./echo__FILE__.rb\n"),
  Struct::TC.new(here, 'lib/', "lib/echo__FILE__.rb\n"),
  Struct::TC.new(here, "#{here}/lib/", "#{here}/lib/echo__FILE__.rb\n"),
  Struct::TC.new('/',  "#{here[1..-1]}/lib/", "#{here[1..-1]}/lib/echo__FILE__.rb\n"),
]

test_cases.each_with_index do |tc,i|
  Dir.chdir(tc.pwd) do
    test(`#{A_OUT} #{tc.prefix}echo__FILE__.rb`, tc.result, "[#{i}] #{tc}")
  end
end

# Make sure if file does not end in .rb, that __FILE__ does not end in .rb
test(`#{A_OUT} #{here}/lib/echo__FILE__`, "#{here}/lib/echo__FILE__\n", 'no .rb')

# ############################################################
# Ensure #" ($LOADED_FEATURES) is set correctly
# ############################################################


# ############################################################
report
