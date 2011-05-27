require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "neo_rest"
    gem.summary = %Q{a rest wrapper for the Neo4j rest API}
    gem.description = %Q{a rest wrapper for the Neo4j rest API}
    gem.email = "mark.nijhof@cre8ivethought.com"
    gem.homepage = "http://github.com/MarkNijhof/NeoRest"
    gem.authors = ["Mark Nijhof"]
    gem.add_development_dependency "rspec", '2.6.0'
    gem.add_dependency "json", '1.5.1'
    gem.add_dependency "rest-client", '1.6.1'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :test => [:set_test_environment] do
  sh "bundle exec watchr"
end

task :neo_stop do
  sh "~/neo4j-server-dev/bin/neo4j stop"
  sh "~/neo4j-server/bin/neo4j stop"
end

task :neo_start do
  sh "~/neo4j-server-dev/bin/neo4j start"
  sh "~/neo4j-server/bin/neo4j start"
end

task :set_test_environment do
  ENV['AUTOFEATURE'] = "true"
  ENV['RSPEC'] = "true"

  ENV['NEO4J_HOST'] = 'localhost'
  ENV['NEO4J_PORT'] = '7474'
end

task :default => :test