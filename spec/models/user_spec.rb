require 'spec_helper'

describe User do
  
 
  # Candidate_Signup_5.1.6.1
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  context "for first_name" do
    # Candidate_Signup_5.1.6._FirstName_002
    it "is invalid without a first_name"  do
      FactoryGirl.build(:user, :first_name => nil).should_not be_valid
      @user = FactoryGirl.build(:user, :first_name => "")
      @user.should_not be_valid
      @user.should have(1).error_on(:first_name)
    end
    # Candidate_Signup_5.1.6._FirstName_003_a
    it "is invalid with first_name > 50 " do
      @user = FactoryGirl.build(:user, :first_name => "a"*51)
      @user.should_not be_valid
      @user.should have(1).error_on(:first_name)
    end
    # Candidate_Signup_5.1.6._FirstName_003_b
    it "is valid with first_name length 1"  do
      FactoryGirl.build(:user, :first_name => "s").should be_valid
    end
    # Candidate_Signup_5.1.6._FirstName_003_c
    it "is valid with first_name = 50" do
      FactoryGirl.build(:user, :first_name => "a"*50).should be_valid
    end
    # Candidate_Signup_5.1.6._FirstName_003_d
    it "is valid with space in first_name"  do
      FactoryGirl.build(:user, :first_name => "sat ish").should be_valid
    end
    # Candidate_Signup_5.1.6._FirstName_003_e
    it "is valid with special char in first_name"  do
      FactoryGirl.build(:user, :first_name => "$@ti$h").should be_valid
    end
  end
  
  context "for last_name" do
    # Candidate_Signup_5.1.6_LastName_004
    it "is invalid without a last_name"  do
      FactoryGirl.build(:user, :last_name => nil).should_not be_valid
      @user = FactoryGirl.build(:user, :last_name => "")
      @user.should_not be_valid
      @user.should have(1).error_on(:last_name)
    end
    # Candidate_Signup_5.1.6_LastName_005_a
    it "is invalid with last_name > 50 " do
      @user = FactoryGirl.build(:user, :last_name => "p"*51)
      @user.should_not be_valid
      @user.should have(1).error_on(:last_name)
    end
    # Candidate_Signup_5.1.6._LastName_005_b
    it "is valid with last_name length 1"  do
      FactoryGirl.build(:user, :last_name => "s").should be_valid
    end
    # Candidate_Signup_5.1.6._LastName_005_c
    it "is invalid with last_name = 50" do
      FactoryGirl.build(:user, :last_name => "A"*50).should be_valid
    end
    # Candidate_Signup_5.1.6._LastName_005_d
    it "is valid with space in last_name"  do
      FactoryGirl.build(:user, :last_name => "pat il").should be_valid
    end
    # Candidate_Signup_5.1.6._LastName_005_e
    it "is valid with special char in last_name"  do
      FactoryGirl.build(:user, :last_name => "p@til").should be_valid
    end
    
  end 

  context "for email" do
    # Candidate_Signup_5.1.6_Email_006
    it "is invalid without a email" do
      FactoryGirl.build(:user, :email => nil).should_not be_valid
      @user = FactoryGirl.build(:user, :email => "")
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_b
    it "is invalid without domain(dot missing) in email" do
      @user = FactoryGirl.build(:user, :email => "satishg.aher@gmailcom")
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_c
    it "is invalid with special charector in email" do
      @user = FactoryGirl.build(:user, :email => "$atishg.aher@gmail.com")
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_d
    it "is invalid with space charector in email" do
      @user = FactoryGirl.build(:user, :email => "satishg aher@gmail.com")
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_e
    it "is invalid with two consecutive dots in email" do
      @user = FactoryGirl.build(:user, :email => "satishg.aher@gmail..com")
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_f
    it "is invalid with special charector in email" do
      @user = FactoryGirl.build(:user, :email => "satishg.ahergmail.com")
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_g
    it "user with same email is not valid" do
      FactoryGirl.create(:user).should be_valid
      FactoryGirl.build(:user).should_not be_valid
      @user =  FactoryGirl.build(:user)        
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_h
    it "is invalid with email length > 256" do
      @user = FactoryGirl.build(:user, :email => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@gmail.com")
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
    end
    # Candidate_Signup_5.1.6_Email_006_i
    it "is valid with email length = 256" do
      @user = FactoryGirl.build(:user, :email => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@gmail.com")
      @user.should be_valid
    end
    # Candidate_Signup_5.1.6_Email_006_j
    it "is valid with email cahrcters CAPS" do
      @user = FactoryGirl.build(:user, :email => "SATISHG.AHER@GMAIL.COM")
      @user.should be_valid
    end
    # Candidate_Signup_5.1.6_Email_006_k
    it "is valid with alfa numeric in email" do
      FactoryGirl.build(:user, :email => "amol123@gmail.com").should be_valid
    end
    it "is valid with emails as" do
      FactoryGirl.build(:user, :email => "amol123@gmail.com").should be_valid
      FactoryGirl.build(:user, :email => "amol123@gmail.co.in").should be_valid
      FactoryGirl.build(:user, :email => "amol_123@gmail.co").should be_valid
      FactoryGirl.build(:user, :email => "amol-123@gmail.com").should be_valid
      FactoryGirl.build(:user, :email => "amol.123@gmail.com").should be_valid
    end
    it "is invalid with dot at the end" do
      FactoryGirl.build(:user, :email => "amol123@gmail.oo.").should_not be_valid
      FactoryGirl.build(:user, :email => "amol123@gmail.com.").should_not be_valid
    end
    
  end

  context "for password" do
    # Candidate_Signup_5.1.6_password_007
    it "is invalid with blank/nil password " do
      FactoryGirl.build(:user, :password => '' ).should_not be_valid
      FactoryGirl.build(:user, :password => nil ).should_not be_valid
    end
    # Candidate_Signup_5.1.6_confirmpassword_008
    it "is invalid if password and confirm pass dose not match" do
      FactoryGirl.build(:user, :password => "password",:password_confirmation => 'password1' ).should_not be_valid
      @user = FactoryGirl.build(:user, :password => "password",:password_confirmation => 'password1' ) 
      @user.should have(1).error_on(:password)
    end
    # Candidate_Signup_5.1.6_passwordlength_009
    it "is invalid with password of length < 8" do
      FactoryGirl.build(:user, :password => 'short' ).should_not be_valid
      FactoryGirl.build(:user, :password => '' ).should_not be_valid
      FactoryGirl.build(:user, :password => 'shortpa' ).should_not be_valid
    end
    # Candidate_Signup_5.1.6_passwordlength_010_a
    it "is invalid with password of length > 23" do
      FactoryGirl.build(:user, :password => 'a'*24 ).should_not be_valid
    end
    # Candidate_Signup_5.1.6_passwordlength_010_b
    it "is valid with password of length = 8" do
      FactoryGirl.build(:user, :password => 'a'*8 ,:password_confirmation => 'a'*8 ).should be_valid
    end
    # Candidate_Signup_5.1.6_passwordlength_010_c
    it "is valid with password of length = 23" do
      FactoryGirl.build(:user, :password => 'a'*23 ,:password_confirmation => 'a'*23 ).should be_valid
    end
  
  end
  
end
