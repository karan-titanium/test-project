require 'spec_helper'

describe Trait do
  it "has a valid factory" do
    FactoryGirl.create(:trait).should be_valid
  end
  
  
  context "for name" do
    it "is valid without name" do
      FactoryGirl.build(:trait, :name => nil).should_not be_valid
      @trait = FactoryGirl.build(:trait, :name => "")
      @trait.should_not be_valid
    end
    
    it "is valid with length of trait name = 1" do
      FactoryGirl.build(:trait, :name => "a").should be_valid
    end
    
    it "is valid with 50 chars" do
      FactoryGirl.build(:trait, :name => "a"*50).should be_valid
    end
    
    it "is valid with > 50 chars" do
      FactoryGirl.build(:trait, :name => "a"*51).should_not be_valid
    end
    
    it "is valid with alphanumeric chars" do
      FactoryGirl.build(:trait, :name => "B4U").should be_valid
    end
    
    it "is valid with alphanumeric value in trait name"  do
      FactoryGirl.build(:trait, :name => "Numeracy123").should be_valid
    end
    
    it "is valid with space in trait name"  do
      FactoryGirl.build(:trait, :name => "Numeracy Trait").should be_valid
    end
  end
  
  
  context "for description" do
    it "is valid without description" do
      FactoryGirl.build(:trait, :description => nil).should_not be_valid
      @trait = FactoryGirl.build(:trait, :description => "")
      @trait.should_not be_valid
    end
    
    it "is valid with length of description = 1" do
      FactoryGirl.build(:trait, :description => "a").should be_valid
    end
    
    it "is valid with 250 chars" do
      FactoryGirl.build(:trait, :description => "a"*250).should be_valid
    end
    
    it "is valid with > 250 chars" do
      FactoryGirl.build(:trait, :description => "a"*251).should_not be_valid
    end
    
    it "is valid with alphanumeric chars" do
      FactoryGirl.build(:trait, :description => "B4U").should be_valid
    end
    
    it "is valid with alphanumeric value in description"  do
      FactoryGirl.build(:trait, :description => "Description123").should be_valid
    end
    
    it "is valid with space in description"  do
      FactoryGirl.build(:trait, :description => "Description Trait").should be_valid
    end
  end
  
  
  context "for trait status" do
    
    it "is invalid without a trait status"  do
      FactoryGirl.build(:trait, :status => nil).should_not be_valid
      @language = FactoryGirl.build(:trait, :status => "")
      @language.should_not be_valid
    end
    
    it "is valid with internal" do
      FactoryGirl.build(:trait, :status => "internal").should be_valid
    end
    it "is valid with public" do
      FactoryGirl.build(:trait, :status => "public").should be_valid
    end
    it "is valid with deleted" do
      FactoryGirl.build(:trait, :status => "deleted").should be_valid
    end
  end
  
  
end
