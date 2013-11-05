require 'spec_helper'

describe QualificationGrade do
    
  it "has a valid factory" do
    FactoryGirl.create(:qualification_grade).should be_valid
  end
  
  context "for qualification grade name" do
   
    it "is invalid without a qualification grade name" do
      FactoryGirl.build(:qualification_grade, :name => nil).should_not be_valid
      @qualification_grade = FactoryGirl.build(:qualification_grade, :name => "")
      @qualification_grade.should_not be_valid
    end
    
    it "is invalid with qualification grade name > 50 " do
      @qualification_grade = FactoryGirl.build(:qualification_grade, :name => "e"*51)
      @qualification_grade.should_not be_valid
    end
    
    it "is valid with length of qualification grade name = 1" do
      FactoryGirl.build(:qualification_grade, :name => "T").should be_valid
    end
   
    it "is valid with length of qualification grade name = 50" do
      FactoryGirl.build(:qualification_grade, :name => "e"*50).should be_valid
    end
   
    it "is valid with space in qualification grade name" do
      FactoryGirl.build(:qualification_grade, :name => "First Class with Distiction").should be_valid
    end
    
    it "is valid with alphanumeric value in qualification grade name" do
      FactoryGirl.build(:qualification_grade, :name => "pass123").should be_valid
    end
    
    it "is valid with special character in qualification grade name" do
      FactoryGirl.build(:qualification_grade, :name => "@atkt!").should be_valid
    end
    
  end
  
  context "for qualification grade status" do
    
    it "is invalid without a qualification grade status" do
      FactoryGirl.build(:qualification_grade, :status => nil).should be_valid
      @qualification_grade = FactoryGirl.build(:qualification_grade, :status => "")
      @qualification_grade.should be_valid
    end
  end
  
  context "for qualification type" do
    
    it "is invalid without a qualification type" do
      FactoryGirl.build(:qualification_grade, :qualification_type_id => nil).should_not be_valid
      @qualification_grade = FactoryGirl.build(:qualification_grade, :qualification_type_id => "")
      @qualification_grade.should_not be_valid
    end
  end
  
  context "for qualification grade order" do
    
    it "is invalid without a qualification type" do
      FactoryGirl.build(:qualification_grade, :order => nil).should be_valid
      @qualification_grade = FactoryGirl.build(:qualification_grade, :order => "")
      @qualification_grade.should be_valid
    end
    
    it "is valid with only numeric values" do
      FactoryGirl.build(:qualification_grade, :order => "12").should be_valid
    end 
    
    it "is valid with length of qualification grade name = 5" do
      FactoryGirl.build(:qualification_grade, :order => "1"*5).should be_valid
    end 
    
    it "is valid with length of qualification grade name > 5" do
      FactoryGirl.build(:qualification_grade, :order => "1"*6).should_not be_valid
    end 
    
    it "is valid with alphanumeric value in qualification grade order" do
      FactoryGirl.build(:qualification_grade, :order => "pass123").should_not be_valid
    end
    
    it "is valid with special character in qualification grade order" do
      FactoryGirl.build(:qualification_grade, :order => "@123!").should_not be_valid
    end
  end
  
  
end
