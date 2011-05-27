require 'rake'

require './lib/neo_rest'

RSpec.configure do |config|
  config.mock_with :rspec
  
  NeoRest::Config.init
  
  config.before(:each, :neo4j => true) do
    NeoRest::TestHelper.clean_the_whole_database 'yeah_delete_it_all'
  end
end
