require 'spec_helper'

describe UserFile do
  it "has a valid factory" do
    FactoryGirl.create(:user_file).should be_valid
  end
  
context "user_id" do 
  it "is valid without user id" do
    FactoryGirl.build(:user_file, :user_id => nil ).should_not be_valid
    @user_file = FactoryGirl.build(:user_file, :user_id => "")
    @user_file.should_not be_valid
  end
end 

context "user file type" do 
  it "is valid without user file type" do
    FactoryGirl.build(:user_file, :user_file_type => nil ).should_not be_valid
    @user_file = FactoryGirl.build(:user_file, :user_file_type => "")
    @user_file.should_not be_valid
  end
  
  it "is valid with user file type cv" do
    FactoryGirl.build(:user_file, :user_file_type => "cv" ).should be_valid
  end
  
  it "is valid with user file type other" do
    FactoryGirl.build(:user_file, :user_file_type => "other" ).should be_valid
  end
end

context "cdn file id" do
  it "is valid without cdn file id" do
    FactoryGirl.build(:user_file, :cdn_file_id => nil ).should_not be_valid
    @user_file = FactoryGirl.build(:user_file, :cdn_file_id => "")
    @user_file.should_not be_valid
  end
end 
end
