require 'spec_helper'

describe UserOtherskill do
 it "has a valid factory" do
    FactoryGirl.create(:user_otherskill).should be_valid
  end
  
  context "user_id" do 
    it "is valid without user id " do
      FactoryGirl.build(:user_otherskill, :user_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_otherskill, :user_id => "")
      @object.should_not be_valid
    end
  end
  
  context "skill" do 
    it "is valid without skill " do
      FactoryGirl.build(:user_otherskill, :skill => nil).should_not be_valid
      @object = FactoryGirl.build(:user_otherskill, :skill => "")
      @object.should_not be_valid
    end
    
    it "is valid with 1 chars" do
      FactoryGirl.build(:user_otherskill, :skill => 'a').should be_valid
    end
    
    it "is valid with 250 chars" do
      FactoryGirl.build(:user_otherskill, :skill => 'a'*250).should be_valid
    end
    
    it "is valid with > 250 chars" do
      FactoryGirl.build(:user_otherskill, :skill => 'a'*251).should_not be_valid
    end
    
    it "is valid with alphanumeric chars" do
      FactoryGirl.build(:user_otherskill, :skill => '1a1'*25).should be_valid
    end
  end
  
  context "experience" do 
    it "is valid without experience " do
      FactoryGirl.build(:user_otherskill, :experience => nil).should_not be_valid
      @object = FactoryGirl.build(:user_otherskill, :experience => "")
      @object.should_not be_valid
    end
    
    it "is valid with alphanumeric chars " do
      FactoryGirl.build(:user_otherskill, :experience => 'abc123').should_not be_valid
    end
    
    it "is valid with digits <= 5 " do
      FactoryGirl.build(:user_otherskill, :experience => 12345).should be_valid
    end
    
    it "is valid with digits > 5 " do
      FactoryGirl.build(:user_otherskill, :experience => 123456).should_not be_valid
    end
  end
  
  context "level" do 
    it "is valid without level " do
      FactoryGirl.build(:user_otherskill, :level => nil).should_not be_valid
      @object = FactoryGirl.build(:user_otherskill, :level => "")
      @object.should_not be_valid
    end
    
    it "is valid with level basic" do
      FactoryGirl.build(:user_otherskill, :level => 'basic').should be_valid
    end
    
    it "is valid with level intermediate " do
      FactoryGirl.build(:user_otherskill, :level => 'intermediate').should be_valid
    end
    
    it "is valid with level advanced " do
      FactoryGirl.build(:user_otherskill, :level => 'advanced').should be_valid
    end
    
    it "is valid with level abc" do
      FactoryGirl.build(:user_otherskill, :level => 'abc').should_not be_valid
    end
  end
end
