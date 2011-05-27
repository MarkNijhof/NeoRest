
module NeoRest
  
  class Config
    class << self
      def init 
        $neo_host = 'localhost'
        $neo_port = 7474
        $neo_base_url = "http://#{$neo_host}:#{$neo_port}/db/data"
      end
    end
  end
end