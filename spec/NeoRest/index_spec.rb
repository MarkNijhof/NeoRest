
require 'spec_helper'

describe "NeoRest::Index" do

  describe "get_nodes", :neo4j => true do

    it "will get all the nodes from an index" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )
      
      new_node_1.add_to_index :friends, :name, 'node name 1'
      new_node_2.add_to_index :friends, :name, 'node name 1'
      
      nodes = NeoRest::Index.get_nodes :friends, :name, 'node name 1'
      nodes.count.should == 2
      nodes[0].neo_id.should == new_node_1.neo_id
      nodes[1].neo_id.should == new_node_2.neo_id
    end

    it "will get all the nodes from an index" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )
      
      index = new_node_1.add_to_index :friends, :name, 'node name 1'
      new_node_2.add_to_index :friends, :name, 'node name 1'
      
      nodes = index.get_nodes
      nodes.count.should == 2
      nodes[0].neo_id.should == new_node_1.neo_id
      nodes[1].neo_id.should == new_node_2.neo_id
    end

  end
  
  describe "delete", :neo4j => true do

    it "will remove a node from the index using neo_id" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )
      
      index = new_node_1.add_to_index :friends, :name, 'node name 1'
      new_node_2.add_to_index :friends, :name, 'node name 1'
      
      index.remove new_node_1.neo_id
      
      nodes = NeoRest::Index.get_nodes :friends, :name, 'node name 1'
      nodes.count.should == 1
      nodes[0].neo_id.should == new_node_2.neo_id
    end

    it "will remove a node from the index using node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )
      
      index = new_node_1.add_to_index :friends, :name, 'node name 1'
      new_node_2.add_to_index :friends, :name, 'node name 1'
      
      index.remove new_node_1
      
      nodes = NeoRest::Index.get_nodes :friends, :name, 'node name 1'
      nodes.count.should == 1
      nodes[0].neo_id.should == new_node_2.neo_id
    end
    
  end

end