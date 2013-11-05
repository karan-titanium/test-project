require 'spec_helper'

describe QuestionCategory do
  it "has a valid factory" do
    FactoryGirl.create(:question_category).should be_valid
  end
  
  
  context "for name" do
    it "is valid without name" do
      FactoryGirl.build(:question_category, :name => nil).should_not be_valid
      @question_category = FactoryGirl.build(:question_category, :name => "")
      @question_category.should_not be_valid
    end
    
    it "is valid with length of question type name = 1" do
      FactoryGirl.build(:question_category, :name => "a").should be_valid
    end
    
    it "is valid with 50 chars" do
      FactoryGirl.build(:question_category, :name => "a"*50).should be_valid
    end
    
    it "is valid with > 50 chars" do
      FactoryGirl.build(:question_category, :name => "a"*51).should_not be_valid
    end
    
    it "is valid with alphanumeric chars" do
      FactoryGirl.build(:question_category, :name => "B4U").should be_valid
    end
    
    it "is valid with alphanumeric value in question type name"  do
      FactoryGirl.build(:question_category, :name => "Numeracy123").should be_valid
    end
    
    it "is valid with space in question type name"  do
      FactoryGirl.build(:question_category, :name => "Numeracy Question").should be_valid
    end
  end
  
  context "for trait id" do
    it "is valid without trait" do
      FactoryGirl.build(:question_category, :trait_id => nil).should be_valid
      @question_category = FactoryGirl.build(:question_category, :trait_id => "")
      @question_category.should be_valid
    end
  end
  
  context "for question category status" do
    
    it "is invalid without a question category status"  do
      FactoryGirl.build(:question_category, :status => nil).should_not be_valid
      @question_category = FactoryGirl.build(:question_category, :status => "")
      @question_category.should_not be_valid
    end
    
    it "is valid with active" do
      FactoryGirl.build(:question_category, :status => "active").should be_valid
    end
    
    it "is valid with deleted" do
      FactoryGirl.build(:question_category, :status => "deleted").should be_valid
    end
  end
  
end
