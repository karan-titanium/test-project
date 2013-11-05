require 'spec_helper'

describe Itskill do
  it "has a valid factory" do
    FactoryGirl.create(:itskill).should be_valid
  end
  
  
  context "name" do
    it "is valid without name" do
      FactoryGirl.build(:itskill, :name => nil).should_not be_valid
      @object = FactoryGirl.build(:itskill, :name => "")
      @object.should_not be_valid
    end
    
    it "is valid with 1 chars" do
      FactoryGirl.build(:itskill, :name => "a").should be_valid
    end
    it "is valid with 50 chars" do
      FactoryGirl.build(:itskill, :name => "a"*50).should be_valid
    end
    it "is valid with > 50 chars" do
      FactoryGirl.build(:itskill, :name => "a"*51).should_not be_valid
    end
    it "is valid with alphanumeric chars" do
      FactoryGirl.build(:itskill, :name => "B4U").should be_valid
    end
  end
  
  
  context "itskill status" do
      it "is valid without status" do
        FactoryGirl.build(:itskill, :status => nil).should be_valid
        @object = FactoryGirl.build(:itskill, :status => "")
        @object.should be_valid
      end
      it "is valid with active" do
        FactoryGirl.build(:itskill, :status => "active").should be_valid
      end
      it "is valid with inactive" do
        FactoryGirl.build(:itskill, :status => "inactive").should_not be_valid
      end
      it "is valid with unconfirmed" do
        FactoryGirl.build(:itskill, :status => "unconfirmed").should be_valid
      end
      it "is valid with deleted" do
        FactoryGirl.build(:itskill, :status => "deleted").should be_valid
      end
      it "is valid with abc" do
        FactoryGirl.build(:itskill, :status => "abc").should_not be_valid
      end
  end
end


  
 
