require 'spec_helper'

describe UserLanguage do
  it "has a valid factory" do
    FactoryGirl.create(:user_language).should be_valid
  end
  
  context "user_id" do 
    it "is valid without user id " do
      FactoryGirl.build(:user_language, :user_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_language, :user_id => "")
      @object.should_not be_valid
    end
  end
  
  context "language_id" do 
    it "is valid without language_id " do
      FactoryGirl.build(:user_language, :language_id => nil).should_not be_valid
      @object = FactoryGirl.build(:user_language, :language_id => "")
      @object.should_not be_valid
    end
  end
  
  context "spoken" do 
    it "is valid without  spoken level " do
      FactoryGirl.build(:user_language, :spoken => nil).should_not be_valid
      @object = FactoryGirl.build(:user_language, :spoken => "")
      @object.should_not be_valid
    end
    
    it "is valid with spoken level basic" do
      FactoryGirl.build(:user_language, :spoken => 'basic').should be_valid
    end
    
    it "is valid with spoken level intermediate " do
      FactoryGirl.build(:user_language, :spoken => 'intermediate').should be_valid
    end
    
    it "is valid with spoken level advanced " do
      FactoryGirl.build(:user_language, :spoken => 'advanced').should be_valid
    end
    
    it "is valid with spoken level abc" do
      FactoryGirl.build(:user_language, :spoken => 'abc').should_not be_valid
    end
  end
  
   context "written" do 
    it "is valid without  written level " do
      FactoryGirl.build(:user_language, :written => nil).should_not be_valid
      @object = FactoryGirl.build(:user_language, :written => "")
      @object.should_not be_valid
    end
    
    it "is valid with written level basic" do
      FactoryGirl.build(:user_language, :written => 'basic').should be_valid
    end
    
    it "is valid with written level intermediate " do
      FactoryGirl.build(:user_language, :written => 'intermediate').should be_valid
    end
    
    it "is valid with written level advanced " do
      FactoryGirl.build(:user_language, :written => 'advanced').should be_valid
    end
    
    it "is valid with written level abc" do
      FactoryGirl.build(:user_language, :written => 'abc').should_not be_valid
    end
  end
  
end
