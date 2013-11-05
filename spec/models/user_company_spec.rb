require 'spec_helper'

describe UserCompany do
  it "has a valid factory" do
    FactoryGirl.create(:user_company).should be_valid
  end
  
  
context "for company id" do
  it "is valid without company id"  do
      FactoryGirl.build(:user_company, :company_id => nil).should_not be_valid
      @user = FactoryGirl.build(:user_company, :company_id => "")
      @user.should_not be_valid
  end
  it "is valid with company id"  do
      FactoryGirl.build(:user_company, :company_id => 1).should be_valid
  end
end  
context "for user id" do
  it "is valid without user id"  do
      FactoryGirl.build(:user_company, :user_id => nil).should_not be_valid
      @user = FactoryGirl.build(:user_company, :user_id => "")
      @user.should_not be_valid
  end
  it "is valid with user id"  do
      FactoryGirl.build(:user_company, :user_id => 1).should be_valid
  end
end  
context "for current" do
  it "is valid without current"  do
      FactoryGirl.build(:user_company, :current => nil).should be_valid
      @user = FactoryGirl.build(:user_company, :current => "")
      @user.should be_valid
  end
  it "is valid with yes"  do
      FactoryGirl.build(:user_company, :current => true).should be_valid
  end
  it "is valid with no"  do
      FactoryGirl.build(:user_company, :current => false).should be_valid
  end
end  
  
context "for clientcontact" do
  it "is valid without clientcontact"  do
      FactoryGirl.build(:user_company, :clientcontact => nil).should be_valid
      @user = FactoryGirl.build(:user_company, :clientcontact => "")
      @user.should be_valid
  end
  it "is valid with true"  do
      FactoryGirl.build(:user_company, :clientcontact => true).should be_valid
  end
end  
  
context "for from" do
  it "is valid without from"  do
      FactoryGirl.build(:user_company, :from => nil).should be_valid
      @user = FactoryGirl.build(:user_company, :from => "")
      @user.should be_valid
  end
end  

context "for untill" do
  it "is valid without untill"  do
      FactoryGirl.build(:user_company, :untill => nil).should be_valid
      @user = FactoryGirl.build(:user_company, :untill => "")
      @user.should be_valid
  end
end  
  
  
context "for position" do
  it "is valid without position"  do
      FactoryGirl.build(:user_company, :position => nil).should be_valid
      @user = FactoryGirl.build(:user_company, :position => "")
      @user.should be_valid
  end
  it "is valid with 1 chars"  do
      FactoryGirl.build(:user_company, :position => "A").should be_valid
  end
  it "is valid with alphanumeric"  do
      FactoryGirl.build(:user_company, :position => "A!@23").should be_valid
  end
  it "is valid with > 50 chars"  do
      FactoryGirl.build(:user_company, :position => "A"*51).should_not be_valid
  end
  it "is valid with  50 chars"  do
      FactoryGirl.build(:user_company, :position => "A"*50).should be_valid
  end
end  
  
end
