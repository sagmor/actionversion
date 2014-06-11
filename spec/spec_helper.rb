begin
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
rescue LoadError
end

require "actionversion"

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }
