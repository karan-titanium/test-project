require 'spec_helper'

describe QualificationLocation do
  
  it "has a valid factory" do
    FactoryGirl.create(:qualification_location).should be_valid
  end
  
  context "for qualification location name" do
   
    it "is invalid without a qualification location name"  do
      FactoryGirl.build(:qualification_location, :name => nil).should_not be_valid
      @qualification_location = FactoryGirl.build(:qualification_location, :name => "")
      @qualification_location.should_not be_valid
      @qualification_location.should have(1).error_on(:name)
    end
    
    it "is invalid with qualification location name > 50 " do
      @qualification_location = FactoryGirl.build(:qualification_location, :name => "e"*51)
      @qualification_location.should_not be_valid
      @qualification_location.should have(1).error_on(:name)
    end
    
    it "is valid with length of qualification location name = 1"  do
      FactoryGirl.build(:qualification_location, :name => "P").should be_valid
    end
   
    it "is valid with length of qualification location name = 50" do
      FactoryGirl.build(:qualification_location, :name => "e"*50).should be_valid
    end
     
    it "is valid with space in qualification location name"  do
      FactoryGirl.build(:qualification_location, :name => "University of Pune").should be_valid
    end
    
    it "is valid with alphanumeric value in qualification location name"  do
      FactoryGirl.build(:qualification_location, :name => "mumbai123").should be_valid
    end
    
    it "is valid with special character in qualification location name"  do
      FactoryGirl.build(:qualification_location, :name => "@mumb@i!").should be_valid
    end
    
  end
  
  context "for qualification location status" do
    
    it "is invalid without a qualification location status"  do
        FactoryGirl.build(:qualification_location, :status => nil).should be_valid
        @qualification_location = FactoryGirl.build(:qualification_location, :status => "")
        @qualification_location.should be_valid
    end
  
    it "is valid with active" do
      FactoryGirl.build(:qualification_location, :status => "active").should be_valid
    end
    
    it "is valid with unconfirmed" do
      FactoryGirl.build(:qualification_location, :status => "unconfirmed").should be_valid
    end
    it "is valid with deleted" do
      FactoryGirl.build(:qualification_location, :status => "deleted").should be_valid
    end
    it "is valid with abc" do
      FactoryGirl.build(:qualification_location, :status => "abc").should_not be_valid
    end
 end

end
