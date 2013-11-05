require 'spec_helper'

describe UserQualification do
  it "has a valid factory" do
    FactoryGirl.create(:user_qualification).should be_valid
  end
  
  context "user_id" do 
    it "is valid without user id " do
      FactoryGirl.build(:user_qualification, :user_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_qualification, :user_id => "")
      @object.should_not be_valid
    end
  end
  
  context "qualification_type_id" do 
    it "is valid without qualification_type_id" do
      FactoryGirl.build(:user_qualification, :qualification_type_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_qualification, :qualification_type_id => "")
      @object.should_not be_valid
    end
  end
  
  context "qualification_location_id" do 
    it "is valid without qualification_location_id " do
      FactoryGirl.build(:user_qualification, :qualification_location_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_qualification, :qualification_location_id => "")
      @object.should_not be_valid
    end
  end
  
  context "qualification_subject_id" do 
    it "is valid without qualification_subject_id " do
      FactoryGirl.build(:user_qualification, :qualification_subject_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_qualification, :qualification_subject_id => "")
      @object.should_not be_valid
    end
  end
  
  
  context "qualification_grade_id" do 
    it "is valid without qualification_grade_id " do
      FactoryGirl.build(:user_qualification, :qualification_grade_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_qualification, :qualification_grade_id => "")
      @object.should_not be_valid
    end
  end
  
 context "year" do 
    it "is valid without year " do
      FactoryGirl.build(:user_qualification, :year => nil).should_not be_valid
      @object = FactoryGirl.build(:user_qualification, :year => "")
      @object.should_not be_valid
    end
    
    it "is valid with < 4 digits " do
      FactoryGirl.build(:user_qualification, :year => 123).should_not be_valid
    end
    
    it "is valid with 4 digits " do
      FactoryGirl.build(:user_qualification, :year => 1234).should be_valid
    end
    
    it "is valid with 5 digits " do
      FactoryGirl.build(:user_qualification, :year => 12345).should_not be_valid
    end
    
    it "is valid with alphanumeric " do
      FactoryGirl.build(:user_qualification, :year => '1qa').should_not be_valid
    end
  end
  
end
