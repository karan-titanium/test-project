require 'spec_helper'

describe QualificationType do
  it "has a valid factory" do
    FactoryGirl.create(:qualification_type).should be_valid
  end
  
  
  context "for name" do
    it "is valid without name" do
      FactoryGirl.build(:qualification_type, :name => nil).should_not be_valid
      @object = FactoryGirl.build(:qualification_type, :name => "")
      @object.should_not be_valid
    end
    
    it "is valid with 1 chars" do
      FactoryGirl.build(:qualification_type, :name => "a").should be_valid
    end
    it "is valid with 50 chars" do
      FactoryGirl.build(:qualification_type, :name => "a"*50).should be_valid
    end
    it "is valid with > 50 chars" do
      FactoryGirl.build(:qualification_type, :name => "a"*51).should_not be_valid
    end
    it "is valid with alphanumeric chars" do
      FactoryGirl.build(:qualification_type, :name => "B4U").should be_valid
    end
  end
  
  
  context "for qualification_type status" do
      it "is valid without status" do
        FactoryGirl.build(:qualification_type, :status => nil).should be_valid
        @object = FactoryGirl.build(:qualification_type, :status => "")
        @object.should be_valid
      end
      it "is valid with active" do
        FactoryGirl.build(:qualification_type, :status => "active").should be_valid
      end
      it "is valid with unconfirmed" do
        FactoryGirl.build(:qualification_type, :status => "unconfirmed").should be_valid
      end
      it "is valid with deleted" do
        FactoryGirl.build(:qualification_type, :status => "deleted").should be_valid
      end
      it "is valid with abc" do
        FactoryGirl.build(:qualification_type, :status => "abc").should_not be_valid
      end
  end
end
