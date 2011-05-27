
module NeoRest
  
  class Config
    class << self
      def init host = 'localhost', port = 7474
        $neo_host = host
        $neo_port = port
        $neo_base_url = "http://#{$neo_host}:#{$neo_port}/db/data"
      end
    end
  end
end