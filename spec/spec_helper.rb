require File.join(File.dirname(__FILE__), '..', 'lib', 'fabulist')
require 'factory_girl'
require 'fabulist/adapter/factory_girl'
Dir.glob(File.dirname(__FILE__) + "/factories/*").each do |factory|
  require factory
end


RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
end
