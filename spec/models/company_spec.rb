require 'spec_helper'

describe Company do
  it "has a valid factory" do
    FactoryGirl.create(:company).should be_valid
  end
  
context "caompany name" do 
  it "is valid without name" do
    FactoryGirl.build(:company, :name => nil).should_not be_valid
    @company = FactoryGirl.build(:company, :name => "")
    @company.should_not be_valid
  end
  it "is valid with 1 chars" do
    FactoryGirl.build(:company, :name => "a").should be_valid
  end
  it "is valid with 50 chars" do
    FactoryGirl.build(:company, :name => "a"*50).should be_valid
  end
  it "is valid with > 50 chars" do
    FactoryGirl.build(:company, :name => "a"*51).should_not be_valid
  end
  it "is valid with alphanumeric chars" do
    FactoryGirl.build(:company, :name => "B4U").should be_valid
  end
end 

context "caompany status" do
  it "is valid without status" do
    FactoryGirl.build(:company, :status => nil).should be_valid
    @company = FactoryGirl.build(:company, :status => "")
    @company.should be_valid
  end
  it "is valid with active" do
    FactoryGirl.build(:company, :status => "active").should be_valid
  end
  it "is valid with unconfirmed" do
    FactoryGirl.build(:company, :status => "unconfirmed").should be_valid
  end
  it "is valid with deleted" do
    FactoryGirl.build(:company, :status => "deleted").should be_valid
  end
  it "is valid with abc" do
    FactoryGirl.build(:company, :status => "abc").should_not be_valid
  end  
end
  
end
