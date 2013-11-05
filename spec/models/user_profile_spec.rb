require 'spec_helper'

describe UserProfile do
  it "has a valid factory" do
    FactoryGirl.create(:user_profile).should be_valid
  end


context "for passport" do
  it "is valid without a passport"  do
      FactoryGirl.build(:user_profile, :passport => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :passport => "")
      @user.should be_valid
  end
  it "is valid with a passport YES"  do
      FactoryGirl.build(:user_profile, :passport => "yes").should be_valid
  end
  it "is valid with a passport NO"  do
      FactoryGirl.build(:user_profile, :passport => "no").should be_valid
  end
end

context "for eligible UK" do
  it "is valid without a eligible UKf"  do
      FactoryGirl.build(:user_profile, :eligableuk => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :eligableuk => "")
      @user.should be_valid
  end
  it "is valid with a passport YES"  do
      FactoryGirl.build(:user_profile, :eligableuk => "yes").should be_valid
  end
  it "is valid with a passport NO"  do
      FactoryGirl.build(:user_profile, :eligableuk => "no").should be_valid
  end
end

context "for eligible details" do
  it "is valid without a eligible details"  do
      FactoryGirl.build(:user_profile, :eligabledetails => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :eligabledetails => "")
      @user.should be_valid
  end
  it "is valid when eligible details one char"  do
      FactoryGirl.build(:user_profile, :eligabledetails => "a").should be_valid
  end
  it "is valid when eligible details 250 char"  do
      FactoryGirl.build(:user_profile, :eligabledetails => "a"*250).should be_valid
  end
  it "is valid when eligible details > 250 char"  do
      FactoryGirl.build(:user_profile, :eligabledetails => "a"*251).should_not be_valid
  end
end

context "for gender" do
  it "is valid without gender"  do
      FactoryGirl.build(:user_profile, :gender => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :gender => "")
      @user.should be_valid
  end
  it "is valid when gender is male"  do
      FactoryGirl.build(:user_profile, :gender => "male").should be_valid
  end
  it "is valid when gender  is female"  do
      FactoryGirl.build(:user_profile, :gender => "female").should be_valid
  end
end

context "for mobile number" do
  it "is valid without mobile number"  do
      FactoryGirl.build(:user_profile, :number_mob => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :number_mob => "")
      @user.should be_valid
  end
  it "is valid when number is 11 digits "  do
      FactoryGirl.build(:user_profile, :number_mob => "07031896976" ).should be_valid
  end
  it "is valid when number is 10 digits"  do
      FactoryGirl.build(:user_profile, :number_mob => "1"*10).should_not be_valid
  end
  it "is valid when number is 15 digits"  do
      FactoryGirl.build(:user_profile, :number_mob => "1"*15).should_not be_valid
  end
  it "is valid when number start with any digit except 0 "  do
      FactoryGirl.build(:user_profile, :number_mob => "70318969761" ).should_not be_valid
  end
  it "is valid when number start with + "  do
      FactoryGirl.build(:user_profile, :number_mob => "+07031896976" ).should_not be_valid
  end
  it "is valid when number start with 074"  do
      FactoryGirl.build(:user_profile, :number_mob => "07400320007" ).should be_valid
  end 
  it "is valid when number start with 075 "  do
      FactoryGirl.build(:user_profile, :number_mob => "07500750000" ).should be_valid
  end
  it "is valid when number start with 076"  do
      FactoryGirl.build(:user_profile, :number_mob => "07603080087" ).should be_valid
  end
  it "is valid when number start with 077 "  do
      FactoryGirl.build(:user_profile, :number_mob => "07703250100" ).should be_valid
  end
  it "is valid when number start with 078 "  do
      FactoryGirl.build(:user_profile, :number_mob => "07805590003" ).should be_valid
  end
  it "is valid when number start with 079 "  do
      FactoryGirl.build(:user_profile, :number_mob => "07901490076" ).should be_valid
  end
  it "is valid when number start with 079 "  do
      FactoryGirl.build(:user_profile, :number_mob => "079014900761" ).should_not be_valid
  end
end

context "for alternate phone number" do
  
end

context "for contact method" do
  it "is valid without contact method"  do
      FactoryGirl.build(:user_profile, :contact_method => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :contact_method => "")
      @user.should be_valid
  end
  it "is valid with email"  do
      FactoryGirl.build(:user_profile, :contact_method => "email").should be_valid
  end
  it "is valid with sms"  do
      FactoryGirl.build(:user_profile, :contact_method => "sms").should be_valid
  end
  it "is valid with sms"  do
      FactoryGirl.build(:user_profile, :contact_method => "mobile").should be_valid
  end
  it "is valid with sms"  do
      FactoryGirl.build(:user_profile, :contact_method => "alt").should be_valid
  end
end

context "for contact time" do
  it "is valid without contact method"  do
      FactoryGirl.build(:user_profile, :contact_time => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :contact_time => "")
      @user.should be_valid
  end
  it "is valid with morning"  do
      FactoryGirl.build(:user_profile, :contact_time => ["morning"]).should be_valid
  end
  it "is valid with morning and afternoon"  do
      FactoryGirl.build(:user_profile, :contact_time => ["morning", "afternoon"]).should be_valid
  end
  it "is valid with morning, afternoon and evening"  do
      FactoryGirl.build(:user_profile, :contact_time => ["morning", "afternoon", "evening"]).should be_valid
  end
  it "is valid with afternoon and evening"  do
      FactoryGirl.build(:user_profile, :contact_time => ["afternoon", "evening"]).should be_valid
  end
end

context "for address line 1" do
  it "is valid without address line 1"  do
      FactoryGirl.build(:user_profile, :address_line1 => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :address_line1 => "")
      @user.should be_valid
  end
  it "is valid with 1 chars"  do
      FactoryGirl.build(:user_profile, :address_line1 => "a").should be_valid
  end
  it "is valid with 100 chars"  do
      FactoryGirl.build(:user_profile, :address_line1 => "a"*100).should be_valid
  end
  it "is valid with 101 chars"  do
      FactoryGirl.build(:user_profile, :address_line1 => "a"*101).should_not be_valid
  end
  it "is valid with alphanumeric chars"  do
      FactoryGirl.build(:user_profile, :address_line1 => "abc123").should be_valid
  end
  it "is valid with special symbols"  do
      FactoryGirl.build(:user_profile, :address_line1 => "B2-Gulmohar").should be_valid
  end
end

context "for address line 2" do
  it "is valid without address line 2"  do
      FactoryGirl.build(:user_profile, :address_line2 => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :address_line2 => "")
      @user.should be_valid
  end
  it "is valid with 1 chars"  do
      FactoryGirl.build(:user_profile, :address_line2 => "a").should be_valid
  end
  it "is valid with 100 chars"  do
      FactoryGirl.build(:user_profile, :address_line2 => "a"*100).should be_valid
  end
  it "is valid with 101 chars"  do
      FactoryGirl.build(:user_profile, :address_line2 => "a"*101).should_not be_valid
  end
  it "is valid with alphanumeric chars"  do
      FactoryGirl.build(:user_profile, :address_line2 => "abc123").should be_valid
  end
  it "is valid with special symbols "  do
      FactoryGirl.build(:user_profile, :address_line2 => "B2-Gulmohar").should be_valid
  end
end

context "for address town" do
  it "is valid without address town"  do
      FactoryGirl.build(:user_profile, :address_town => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :address_town => "")
      @user.should be_valid
  end
  it "is valid with 1 chars"  do
      FactoryGirl.build(:user_profile, :address_town => "a").should be_valid
  end
  it "is valid with 50 chars"  do
      FactoryGirl.build(:user_profile, :address_town => "a"*50).should be_valid
  end
  it "is valid with > 50 chars"  do
      FactoryGirl.build(:user_profile, :address_town => "a"*51).should_not be_valid
  end
  it "is valid with alphanumeric chars"  do
      FactoryGirl.build(:user_profile, :address_town => "abc123").should be_valid
  end
  it "is valid with special symbols"  do
      FactoryGirl.build(:user_profile, :address_town => "B2-Gulmohar").should be_valid
  end
end

context "for address country" do
  it "is valid without address country"  do
      FactoryGirl.build(:user_profile, :address_country => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :address_country => "")
      @user.should be_valid
  end
  it "is valid with 1 chars"  do
      FactoryGirl.build(:user_profile, :address_country => "a").should be_valid
  end
  it "is valid with 50 chars"  do
      FactoryGirl.build(:user_profile, :address_country => "a"*50).should be_valid
  end
end

context "for address postcode" do
  it "is valid without address postcode"  do
      FactoryGirl.build(:user_profile, :address_postcode => nil).should be_valid
      @user = FactoryGirl.build(:user_profile, :address_postcode => "")
      @user.should be_valid
  end
end


context "for current salary" do
  it "is valid without current salary"  do
    FactoryGirl.build(:user_profile, :salary_current => nil).should be_valid
    @user = FactoryGirl.build(:user_profile, :salary_current => "")
      @user.should be_valid
  end
  it "is valid with 11 digits"  do
    FactoryGirl.build(:user_profile, :salary_current => 99999999991).should be_valid
  end
  it "is valid with 1 digits"  do
    FactoryGirl.build(:user_profile, :salary_current => 9).should be_valid
  end
  it "is valid with float value"  do
    FactoryGirl.build(:user_profile, :salary_current => 9877.876).should be_valid
  end
  it "is valid with 0"  do
    FactoryGirl.build(:user_profile, :salary_current => 0).should be_valid
  end
  it "is valid with chars"  do
    FactoryGirl.build(:user_profile, :salary_current => "one lack per month").should_not be_valid
  end
  it "is valid with > 11 digits"  do
    FactoryGirl.build(:user_profile, :salary_current => 123456789011).should_not be_valid
  end
  it "is valid with alphnumeric chars"  do
    FactoryGirl.build(:user_profile, :salary_current => "asd.12333").should_not be_valid
  end
end

context "for target salary" do
  it "is valid without target salary"  do
    FactoryGirl.build(:user_profile, :salary_target => nil).should be_valid
    @user = FactoryGirl.build(:user_profile, :salary_target => "")
      @user.should be_valid
  end
  it "is valid with 11 digits"  do
    FactoryGirl.build(:user_profile, :salary_target => 99999999991).should be_valid
  end
  it "is valid with 1 digits"  do
    FactoryGirl.build(:user_profile, :salary_target => 9).should be_valid
  end
  it "is valid with float value"  do
    FactoryGirl.build(:user_profile, :salary_target => 9877.876).should be_valid
  end
  it "is valid with 0"  do
    FactoryGirl.build(:user_profile, :salary_target => 0).should be_valid
  end
  it "is valid with chars"  do
    FactoryGirl.build(:user_profile, :salary_target => "one lack per month").should_not be_valid
  end
  it "is valid with > 11 digits"  do
    FactoryGirl.build(:user_profile, :salary_target => 123456789011).should_not be_valid
  end
  it "is valid with alphnumeric chars"  do
    FactoryGirl.build(:user_profile, :salary_current => "asd.12333").should_not be_valid
  end
end

end