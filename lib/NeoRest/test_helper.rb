
module NeoRest
  
  class TestHelper
    
    class << self
      
      def clean_the_whole_database delete_key
        # this needs the following plugin installed in the Neo server: https://github.com/jexp/neo4j-clean-remote-db-addon
        RestClient.delete( "http://#{$neo_host}:#{$neo_port}/cleandb/#{delete_key}" )
      end
    
    end
  end
end