require 'spec_helper'

describe UserItskill do
  it "has a valid factory" do
    FactoryGirl.create(:user_itskill).should be_valid
  end
  
  context "user_id" do 
    it "is valid without user id " do
      FactoryGirl.build(:user_itskill, :user_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_itskill, :user_id => "")
      @object.should_not be_valid
    end
  end
  
  context "itskill_id" do 
    it "is valid without itskill_id " do
      FactoryGirl.build(:user_itskill, :itskill_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_itskill, :itskill_id => "")
      @object.should_not be_valid
    end
  end
  
  context "experience" do 
    it "is valid without experience " do
      FactoryGirl.build(:user_itskill, :experience => nil).should_not be_valid
      @object = FactoryGirl.build(:user_itskill, :experience => "")
      @object.should_not be_valid
    end
    
    it "is valid with alphanumeric chars " do
      FactoryGirl.build(:user_itskill, :experience => 'abc123').should_not be_valid
    end
    
    it "is valid with digits <= 5 " do
      FactoryGirl.build(:user_itskill, :experience => 12345).should be_valid
    end
    
    it "is valid with digits > 5 " do
      FactoryGirl.build(:user_itskill, :experience => 123456).should_not be_valid
    end
  end
  
  context "level" do 
    it "is valid without level " do
      FactoryGirl.build(:user_itskill, :level => nil).should_not be_valid
      @object = FactoryGirl.build(:user_itskill, :level => "")
      @object.should_not be_valid
    end
    
    it "is valid with level basic" do
      FactoryGirl.build(:user_itskill, :level => 'basic').should be_valid
    end
    
    it "is valid with level intermediate " do
      FactoryGirl.build(:user_itskill, :level => 'intermediate').should be_valid
    end
    
    it "is valid with level advanced " do
      FactoryGirl.build(:user_itskill, :level => 'advanced').should be_valid
    end
    
    it "is valid with level abc" do
      FactoryGirl.build(:user_itskill, :level => 'abc').should_not be_valid
    end
  end
end
