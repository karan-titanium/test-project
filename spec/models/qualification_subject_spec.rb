require 'spec_helper'

describe QualificationSubject do
  it "has a valid factory" do
    FactoryGirl.create(:qualification_subject).should be_valid
  end
  
  
  context "name" do
    it "is valid without name" do
      FactoryGirl.build(:qualification_subject, :name => nil).should_not be_valid
      @object = FactoryGirl.build(:qualification_subject, :name => "")
      @object.should_not be_valid
    end
    
    it "is valid with 1 chars" do
      FactoryGirl.build(:qualification_subject, :name => "a").should be_valid
    end
    it "is valid with 50 chars" do
      FactoryGirl.build(:qualification_subject, :name => "a"*50).should be_valid
    end
    it "is valid with > 50 chars" do
      FactoryGirl.build(:qualification_subject, :name => "a"*51).should_not be_valid
    end
    it "is valid with alphanumeric chars" do
      FactoryGirl.build(:qualification_subject, :name => "B4U").should be_valid
    end
  end
  
  
  context ":qualification_subject status" do
      it "is valid without status" do
        FactoryGirl.build(:qualification_subject, :status => nil).should be_valid
        @object = FactoryGirl.build(:qualification_subject, :status => "")
        @object.should be_valid
      end
      it "is valid with active" do
        FactoryGirl.build(:qualification_subject, :status => "active").should be_valid
      end
      it "is valid with unconfirmed" do
        FactoryGirl.build(:qualification_subject, :status => "unconfirmed").should be_valid
      end
      it "is valid with deleted" do
        FactoryGirl.build(:qualification_subject, :status => "deleted").should be_valid
      end
      it "is valid with abc" do
        FactoryGirl.build(:qualification_subject, :status => "abc").should_not be_valid
      end
  end
end
