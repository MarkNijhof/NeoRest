require 'uri'
require 'json'
require 'rest-client'
require 'ostruct'

module NeoRest

  class Index < OpenStruct
  
    attr_reader :index_name, :key, :value
  
    def initialize( index_name, key, value )
      @index_name = index_name
      @key = key
      @value = value
    end
    
    def remove node
      node = node.neo_id if node.respond_to?('neo_id')
      RestClient.delete( "#{$neo_base_url}/index/node/#{index_name}/#{key}/#{URI.escape(value)}/#{node}" )
    end

    def get_nodes
      NeoRest::Index.get_nodes index_name, key, value
    end
      
    class << self
    
      def get_nodes index_name, key, value
        nodes_json = JSON.parse( RestClient.get( "#{$neo_base_url}/index/node/#{index_name}/#{key}/#{URI.escape(value)}", :accept => :json ) )
        nodes = []
        nodes_json.each { | node | nodes << NeoRest::Node.new( node ) }
        return nodes unless block_given?
        nodes.each { | node | yield node }
      end
    
    end
    
  end

end