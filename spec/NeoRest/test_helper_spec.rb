
require 'spec_helper'

describe "NeoRest::TestHelper" do

  describe "clean_the_whole_database", :neo4j => true do
    # new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )

    # NeoRest::TestHelper.clean_the_whole_database 'yeah_delete_it_all'

    # new_node.name.should == 'node name'

    # lambda{ NeoRest::Node.load( new_node.neo_id ) }.should raise_error
    # lambda{ raise('test') }.should raise_error
  end
  
end