require 'spec_helper'

describe Language do
  
  it "has a valid factory" do
    FactoryGirl.create(:language).should be_valid
  end
  
  context "for language name" do
   
    it "is invalid without a language name"  do
      FactoryGirl.build(:language, :name => nil).should_not be_valid
      @language = FactoryGirl.build(:language, :name => "")
      @language.should_not be_valid
    end
    
    it "is invalid with language name > 50 " do
      @language = FactoryGirl.build(:language, :name => "e"*51)
      @language.should_not be_valid
    end
    
    it "is valid with length of language name = 1"  do
      FactoryGirl.build(:language, :name => "T").should be_valid
    end
   
    it "is valid with length of language name = 50" do
      FactoryGirl.build(:language, :name => "e"*50).should be_valid
    end
   
    it "is valid with space in language name"  do
      FactoryGirl.build(:language, :name => "English UK").should be_valid
    end
    
    it "is valid with alphanumeric value in language name"  do
      FactoryGirl.build(:language, :name => "Hindi123").should be_valid
    end
    
    it "is valid with special character in language name"  do
      FactoryGirl.build(:language, :name => "@chine$e").should be_valid
    end
    
  end
  
  context "for language status" do
    
    it "is invalid without a language status"  do
      FactoryGirl.build(:language, :status => nil).should be_valid
      @language = FactoryGirl.build(:language, :status => "")
      @language.should be_valid
    end
    
    it "is valid with active" do
      FactoryGirl.build(:language, :status => "active").should be_valid
    end
    it "is valid with unconfirmed" do
      FactoryGirl.build(:language, :status => "unconfirmed").should be_valid
    end
    it "is valid with deleted" do
      FactoryGirl.build(:language, :status => "deleted").should be_valid
    end
  end

end
