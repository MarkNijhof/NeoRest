
require 'spec_helper'

describe "NeoRest::Node" do
  
  describe "create_new", :neo4j => true do

    it "will create a new node" do
      new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )
      new_node.name.should == 'node name'
      new_node.other_property.should == 'property value'
    end

  end

  describe "load", :neo4j => true do

    it "will load an existing node" do
      new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )

      existing_node = NeoRest::Node.load( new_node.neo_id )
      existing_node.name.should == 'node name'
      existing_node.other_property.should == 'property value'
    end

  end

  describe "add_to_index", :neo4j => true do

    it "will add the node to an index" do
      new_node = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      
      new_node.add_to_index :friends, :name, 'node name 1'
      
      nodes = NeoRest::Index.get_nodes :friends, :name, 'node name 1'
      nodes.count.should == 1
      nodes[0].neo_id.should == new_node.neo_id
    end

  end

  describe "add_relationship_to", :neo4j => true do

    it "will add a relationships to a node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      relationship = new_node_1.add_relationship_to new_node_2, :knows
      relationship.start_id.should == new_node_1.neo_id
      relationship.end_id.should == new_node_2.neo_id
      relationship.type.should == "knows"
    end

    it "will add a relationships with meta data to a node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      relationship = new_node_1.add_relationship_to new_node_2, :knows, {:name => 'relation one', :description => 'description one'}
      relationship.name.should == "relation one"
      relationship.description.should == "description one"
    end

  end

  describe "add_relationship_from", :neo4j => true do

    it "will add a relationships from a node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      relationship = new_node_1.add_relationship_from new_node_2, :knows
      relationship.start_id.should == new_node_2.neo_id
      relationship.end_id.should == new_node_1.neo_id
      relationship.type.should == "knows"
    end

    it "will add a relationships with meta data from a node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      relationship = new_node_1.add_relationship_from new_node_2, :knows, {:name => 'relation one', :description => 'description one'}
      relationship.name.should == "relation one"
      relationship.description.should == "description one"
    end

  end

  describe "get_relationships", :neo4j => true do

    it "will load all existing relations of a node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      new_node_1.add_relationship_to new_node_2, :knows
      new_node_1.add_relationship_to new_node_2, :knows, {:name => 'relation one', :description => 'description one'}
      
      relationships = new_node_1.get_relationships
      relationships.count.should == 2
      relationships[1].name.should == 'relation one'
    end

    it "will load all existing relations going out the node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      new_node_1.add_relationship_to new_node_2, :knows
      new_node_1.add_relationship_to new_node_2, :knows, {:name => 'relation one', :description => 'description one'}
      new_node_1.add_relationship_from new_node_2, :knows, {:name => 'relation two', :description => 'description two'}
      
      relationships = new_node_1.get_relationships :out
      relationships.count.should == 2
      relationships[1].name.should == 'relation one'
    end

    it "will load all existing relations going out the node" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      new_node_1.add_relationship_to new_node_2, :knows
      new_node_1.add_relationship_to new_node_2, :knows, {:name => 'relation one', :description => 'description one'}
      new_node_1.add_relationship_from new_node_2, :knows, {:name => 'relation two', :description => 'description two'}
      
      relationships = new_node_1.get_relationships :in
      relationships.count.should == 1
      relationships[0].name.should == 'relation two'
    end

  end

  describe "update", :neo4j => true do

    it "will update an existing node" do
      new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )

      new_node.name = 'new node name'
      new_node.other_property = 'new property value'
      new_node.update

      existing_node = NeoRest::Node.load( new_node.neo_id )
      existing_node.name.should == 'new node name'
      existing_node.other_property.should == 'new property value'
    end

    it "will update an existing node with a hash" do
      new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )

      new_node.update( {:name => 'new node name', :other_property => 'new property value', :new_property => 'value'} )

      new_node.name.should == 'new node name'
      new_node.other_property.should == 'new property value'
      new_node.new_property.should == 'value'

      existing_node = NeoRest::Node.load( new_node.neo_id )
      existing_node.name.should == 'new node name'
      existing_node.other_property.should == 'new property value'
      existing_node.new_property.should == 'value'
    end

  end
  
  describe "delete", :neo4j => true do

    it "will delete an existing node that is loaded" do
      new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )

      new_node.delete

      existing_node = NeoRest::Node.load( new_node.neo_id )
      existing_node.nil?.should == true
    end

    it "will delete an existing node using neo_id" do
      new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )

      NeoRest::Node.delete new_node.neo_id

      existing_node = NeoRest::Node.load( new_node.neo_id )
      existing_node.nil?.should == true
    end

    it "will delete an existing node using node" do
      new_node = NeoRest::Node.create_new( {:name => 'node name', :other_property => 'property value'} )

      NeoRest::Node.delete new_node

      existing_node = NeoRest::Node.load( new_node.neo_id )
      existing_node.nil?.should == true
    end

  end

end