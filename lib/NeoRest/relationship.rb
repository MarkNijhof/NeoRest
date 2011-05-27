require 'json'
require 'rest-client'
require 'ostruct'

module NeoRest

  class Relationship < OpenStruct
  
    attr_reader :neo_id, :neo_url, :start_id, :end_id, :type
  
    def initialize( hash = nil )
      @table = {}
      if hash
        @neo_id = hash["self"].split('/').last
        @neo_url = hash["self"]
        @start_id = hash["start"].split('/').last
        @end_id = hash["end"].split('/').last
        @type = hash["type"]

        for key, value in hash["data"]
          @table[key.to_sym] = value
          new_ostruct_member(key)
        end
      end
    end

    def update properties = {}
      if not properties.empty?
        @table.each { | key, value | delete_field( key ) }
        @table.clear
        
        for key, value in properties
          @table[key.to_sym] = value
          new_ostruct_member(key)
        end
      end
            
      RestClient.put( "#{$neo_base_url}/relationship/#{neo_id}/properties", @table.to_json, :content_type => :json, :accept => :json )
    end
    
    def delete
      NeoRest::Relationship.delete neo_id
    end  
      
    class << self
    
      def load relationship_id
        RestClient.get( "#{$neo_base_url}/relationship/#{relationship_id}", :accept => :json ){ |response, request, result, &block|
          case response.code
            when 200
              NeoRest::Node.new( JSON.parse( response ) )
            when 404
              return nil
            else
              response.return!(request, result, &block)
          end
        }
      end
      
      def delete relationship_id
        RestClient.delete( "#{$neo_base_url}/relationship/#{relationship_id}" )
      end
    
    end
  end

end