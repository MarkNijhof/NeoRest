
require 'spec_helper'

describe "NeoRest::Relationship" do
  
  describe "load", :neo4j => true do

    it "will load an existing relationship" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      new_relationship = new_node_1.add_relationship_to new_node_2, :knows
      new_relationship.name = 'relation one'
      new_relationship.description = 'description one'
      new_relationship.update 
      
      existing_relationship = NeoRest::Relationship.load new_relationship.neo_id
      existing_relationship.neo_id.should == new_relationship.neo_id
    end

  end
  
  describe "update", :neo4j => true do

    it "will update an existing relationship" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      new_relationship = new_node_1.add_relationship_to new_node_2, :knows
      new_relationship.name = 'relation one'
      new_relationship.description = 'description one'
      new_relationship.update 
      
      existing_relationship = NeoRest::Relationship.load new_relationship.neo_id
      existing_relationship.name.should == 'relation one'
      existing_relationship.description.should == 'description one'
    end
    
    it "will update an existing relationship with a hash" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      new_relationship = new_node_1.add_relationship_to new_node_2, :knows
      new_relationship.update( {:name => 'relation one', :description => 'description one', :new_property => 'value'} )
      
      existing_relationship = NeoRest::Relationship.load new_relationship.neo_id
      existing_relationship.name.should == 'relation one'
      existing_relationship.description.should == 'description one'
      existing_relationship.new_property.should == 'value'
    end

  end
  
  describe "delete", :neo4j => true do

    it "will delete an existing relationship that is loaded" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      relationship_1 = new_node_1.add_relationship_to new_node_2, :knows
      relationship_1.delete
    end

    it "will delete an existing relationship" do
      new_node_1 = NeoRest::Node.create_new( {:name => 'node name 1', :other_property => 'property value'} )
      new_node_2 = NeoRest::Node.create_new( {:name => 'node name 2', :other_property => 'property value'} )

      relationship_1 = new_node_1.add_relationship_to new_node_2, :knows
      
      NeoRest::Relationship.delete relationship_1.neo_id
    end

  end

end