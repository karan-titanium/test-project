require 'spec_helper'

describe UsersController do
  describe "Login Failure" do
    before { visit new_user_session_path }
      let(:user) { FactoryGirl.create(:user) }
      # Login_5.1.7.1
      it "with no data in email and password field" do
        fill_in "Email",    with: ""
        fill_in "Password", with: ""
        click_button "Log in" 
        current_path.should eq new_user_session_path
        # page.should have_selector('div', :text => "Invalid email or password")
      end
      # LogIn_5.1.7.2_a
      it "with inactive status user" do 
        user.status = 'inactive'
        user.save
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"      
        current_path.should eq new_user_session_path 
      end
      # LogIn_5.1.7.2_b
      it "with pending status user" do 
        user.status = 'pending'
        user.confirmed_at = nil
        user.save
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"      
        current_path.should eq new_user_session_path  
      end
      # LogIn_5.1.7.2_c
      it "with deleted status user" do 
        user.status = 'deleted'
        user.save
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"      
        current_path.should eq new_user_session_path 
      end
      # LogIn_5.1.7.3
      it "with active status user" do 
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"      
        current_path.should eq '/user_profiles/dashboard'  
        # page.should have_selector('p', :text => "Invalid email or password")
      end
      # LogIn_5.1.7.4
      it "with only email field" do 
        fill_in "Email",    with: user.email
        fill_in "Password", with: ""
        click_button "Log in"      
        current_path.should eq new_user_session_path  
      end
      # LogIn_5.1.7.5
      it "with only password field" do 
        fill_in "Email",    with: ""
        fill_in "Password", with: user.password
        click_button "Log in"      
        current_path.should eq new_user_session_path  
      end
      # LogIn_5.1.7.6
      it "with invalid field" do 
        fill_in "Email",    with: "satish.ahergmail.com"
        fill_in "Password", with: user.password
        click_button "Log in"      
        current_path.should eq new_user_session_path  
      end
      
    end
  describe "Login Sucess" do
    before { visit new_user_session_path }
    # LogIn_5.1.7.29
    describe "with valid staff information" do
      let(:user) { FactoryGirl.create(:staff_user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Log in"
        end
        pending "should redirect to Staff dashboard" do    
           current_path.should eq '/staffs/dashboard'
        end
       # it { should_not have_link('Sign up') }
    end
    # LogIn_5.1.7.30
    describe "with valid Candidate information" do
      # let(:user) { FactoryGirl.create(:user) }
        before do
          user = FactoryGirl.create(:user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Log in"
        end
        it "should redirect to candidate dashboard" do    
           current_path.should eq '/user_profiles/dashboard'
        end
    end
    describe "with valid Client information" do
      pending "should redirect to Client dashboard" do    
           current_path.should eq '/clients/dashboard'
      end      
    end    
    pending "check ip" do 
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"      
        current_path.should eq '/user_profiles/dashboard'
        click_link "Logout" 
        click_link "Login"
        # current_path.should eq '/user_profiles/dashboard'
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"  
        user.sign_in_count.should eq 1
        # user.created_at.should_not eq nil
        
        # user.last_sign_in_ip.should_not eq nil
        # user.current_sign_in_ip.should_not eq nil
        # user.current_sign_in_ip  
      end

  end

        describe "Signup Failure" do
            before { visit new_user_registration_path }
            describe "sign up user" do
              let(:user) { FactoryGirl.create(:user) }
              it "with valid user" do
                fill_in "First name",    with: user.first_name
                fill_in "Last name",    with: user.last_name
                fill_in "Email",    with: user.email
                fill_in "Password", with: user.password
                click_button "Register" 
                current_path.should eq '/users'
                # page.should have_selector('div', :text => "can't be blank")
              end
            end
        end
        describe "Signup Sucess" do
            before { visit new_user_registration_path }
            describe "sign up user" do
              let(:user) { FactoryGirl.build(:user_for_signup) }
              it "with valid user" do
                fill_in "First name",    with: user.first_name
                fill_in "Last name",    with: user.last_name
                fill_in "Email",    with: user.email
                fill_in "Password", with: user.password
                fill_in "Password confirmation", with: user.password_confirmation
                click_button "Register" 
                current_path.should eq '/users'
                # user.status.should_not eq nil
                # page.should have_content(:text => "A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
              end
            end
        end
        describe "Reset password link" do
            before { visit new_user_session_path }
            describe "click" do
              it "with valid Email" do
                user = FactoryGirl.create(:user) 
                click_link "Reset Password"
                fill_in "Email", with: user.email
                # fill_in "Password", with: user.password
                # fill_in "Password confirmation", with: user.password_confirmation
                click_button "Send me reset password instructions" 
                current_path.should eq new_user_session_path
                # user.status.should_not eq nil
                # page.should have_selector('div', :text => "address")
              end
            end
        end
# ////////////////////////////////////////////Login page link testing ////////////////////////////
  describe "Login page links" do
    before do
      visit new_user_session_path
    end
    # LogIn_5.1.7.18
    it "should contain 'Login', 'About Us', 'Contact Us' 'sign up' links" do
      page.should have_link('Login',href: new_user_session_path) 
      page.should have_link('About Us', href: about_us_path)
      page.should have_link('Contact Us', href: contact_us_path)
      page.should have_link('Sign up', href: new_user_registration_path)
    end
    # LogIn_5.1.7.19
    it "click Login" do
      click_link "Login"
      current_path.should eq new_user_session_path
    end
    # LogIn_5.1.7.20
    it "click About Us" do
      click_link "About Us"
      current_path.should eq about_us_path
    end
    # LogIn_5.1.7.21
    it "click Contact Us" do
      click_link "Contact Us"
      current_path.should eq contact_us_path
    end 
    # LogIn_5.1.7.22
    it "click Sign up" do
      click_link "Sign up"
      current_path.should eq new_user_registration_path
    end
    
    
    # LogIn_5.1.7.22_a
    it "should contain 'Log in with LinkedIn' & , 'Log in with Google' links" do
      page.should have_link('Log in with LinkedIn')
      page.should have_link('Log in with Google')
    end 
    
  end
# //////////////////////////////////////// Sign up pages link testing  ///////////////////////

  describe "Signup page links" do
    before do
      visit new_user_registration_path
    end
    # Candidate_Signup_5.1.6.11
    it "should contain 'Login', 'About Us', 'Contact Us' links" do
      page.should have_link('Login',href: new_user_session_path) 
      page.should have_link('About Us', href: about_us_path)
      page.should have_link('Contact Us', href: contact_us_path)
      
    end
    # Candidate_Signup_5.1.6.15
    it "should contain 'Connect with LinkedIn' & , 'Connect with Google' links" do
      page.should have_link('Connect with LinkedIn')
      page.should have_link('Connect with Google')
    end    
    # Candidate_Signup_5.1.6.12
    it "click Login" do
      click_link "Login"
      current_path.should eq new_user_session_path
    end
    # Candidate_Signup_5.1.6.13
    it "click About Us" do
      click_link "About Us"
      current_path.should eq about_us_path
    end
    # Candidate_Signup_5.1.6.14
    it "click Contact Us" do
      click_link "Contact Us"
      current_path.should eq contact_us_path
    end  
  end
  
  describe "Reset password flow" do
    before { visit new_user_password_path }
    let(:user) { FactoryGirl.create(:user) }
    it "enter invalid email and press button 'Send me reset password instructions' "do
      fill_in "Email",    with: "user.email"
      click_button "Send me reset password instructions" 
      current_path.should eq user_password_path  
      # current_path.should eq new_user_session_path
      # page.should have_selector('div', :text => "You will receive an email with instructions about how to reset your password in a few minutes")    
      
    end
    it "enter valid email but not present with tfp and press button 'Send me reset password instructions' "do
      fill_in "Email",    with: ""
      click_button "Send me reset password instructions" 
      current_path.should eq user_password_path    
      page.should have_selector('div', :text => "can't be blank") 
    end
    it "enter valid email & present with tfp and press button 'Send me reset password instructions' "do
      @user = FactoryGirl.create(:user)
      fill_in "Email",    with: @user.email
      click_button "Send me reset password instructions" 
      # current_path.should eq new_user_session_path
      # page.should have_content('You will receive an email with instructions about how to reset your password in a few minutes.')     
    end
    
  
  end

  # //////////////////////////////////////// Static pages flow testing  ///////////////////////
  
  describe "Static page" do
    # About Us 5.1.2.1
    it "About Us should contain 'Candidate Signup', 'Client Info', 'Contact Us' links" do
      visit about_us_path
      page.should have_link('Candidate Signup', href: new_user_registration_path) 
      page.should have_link('Client Info', href: client_info_path)
      page.should have_link('Contact Us', href: contact_us_path)
    end
    # About Us 5.1.2.5
    it "About Us should contain 'About Us', 'Client Info', 'Contact Us' links" do
      visit about_us_path
      page.should have_link('About Us', href: about_us_path)
      page.should have_link('Login') 
    end
    # Home 5.1.1.1
    # Home 5.1.1.4
    it "Home Page should contain 'Candidate', 'Client' links" do
      visit root_path
      page.should have_link('Candidate', href: new_user_registration_path) 
      page.should have_link('Client')
      
      page.should have_link('About Us', href: about_us_path)
      page.should have_link('Contact Us', href: contact_us_path)
      page.should have_link('Login') 
    end
    # Contact Us page 5.1.4.1
    # Contact Us page 5.1.4.4
    it "Contact Us should contain  'Candidate Signup' 'Client Info' links" do
      visit contact_us_path
      page.should have_link('Candidate Signup', href: new_user_registration_path) 
      page.should have_link('Client Info', href: client_info_path)
      
      page.should have_link('About Us', href: about_us_path)
      page.should have_link('Contact Us', href: contact_us_path)
      page.should have_link('Login') 
    end
    # Client Info 5.1.3.1
    it "Client Info should contain  'Candidate Signup' 'Client Info' links" do
      visit contact_us_path
      page.should have_link('Candidate Signup', href: new_user_registration_path) 
      page.should have_link('Client Info', href: client_info_path)
      
      page.should have_link('About Us', href: about_us_path)
      page.should have_link('Contact Us', href: contact_us_path)
      page.should have_link('Login') 
    end
        
  end
  
  describe "About Us page" do
    before do
      visit about_us_path
    end
    # About Us 5.1.2.2
    it "click Candidate Signup" do
      click_link "Candidate Signup"
      current_path.should eq new_user_registration_path
    end
    # About Us 5.1.2.3
    it "click Client info" do
      click_link "Client Info"
      current_path.should eq client_info_path
    end
    # About Us 5.1.2.4
    it "click Contact Us" do
      first(:link, "Contact Us").click
      current_path.should eq contact_us_path
    end
    # About Us 5.1.2.6
    it "click About Us" do
      click_link "About Us"
      current_path.should eq about_us_path
    end
    # About Us 5.1.2.7
    it "click Contact Us" do
      first(:link, "Contact Us").click
      # last(:link, "Contact Us").click
      # page.all('Contact Us')[1].click
      current_path.should eq contact_us_path
    end
    # About Us 5.1.2.8
    it "click Login" do
      click_link "Login"
      current_path.should eq new_user_session_path
    end
  end
  
  describe "Home page" do
    before do
      visit root_path
    end
    # Home 5.1.1.2
    it "click Candidate" do
      click_link "Candidate"
      current_path.should eq new_user_registration_path
    end
    # Home 5.1.1.3
    it "click Client" do
      click_link "Client"
      current_path.should eq client_info_path
    end
    # Home 5.1.1.5
    it "click About Us" do
      click_link "About Us"
      current_path.should eq about_us_path
    end
    # Home 5.1.1.6
    it "click Contact Us" do
      click_link "Contact Us"
      current_path.should eq contact_us_path
    end
    # Home 5.1.1.7
    it "click Login" do
      click_link "Login"
      current_path.should eq new_user_session_path
    end    
  end

  describe "Client Info" do
    before do
      visit client_info_path
    end
    # Client Info 5.1.3.5
    it "click Contact Us To get started " do
      click_link "Contact Us To get started"
      current_path.should eq contact_us_path
    end
    # Client Info 5.1.3.2
    it "click About Us" do
      click_link "About Us"
      current_path.should eq about_us_path
    end
    # Client Info 5.1.3.3
    it "click Contact Us" do
      click_link "Contact Us"
      current_path.should eq contact_us_path
    end
    # Client Info 5.1.3.4
    it "click Login" do
      click_link "Login"
      current_path.should eq new_user_session_path
    end
  end
  
  describe "Contact us" do
    before do
      visit contact_us_path
    end
    # Contact Us page 5.1.4.2
    it "click Candidate Signup " do
      click_link "Candidate Signup"
      current_path.should eq new_user_registration_path
    end
    # Contact Us page 5.1.4.3
    it "click Client Info " do
      click_link "Client Info"
      current_path.should eq client_info_path
    end
    # Contact Us page 5.1.4.5
    it "click About Us" do
      click_link "About Us"
      current_path.should eq about_us_path
    end
    # Contact Us page 5.1.4.6
    it "click Contact Us" do
      click_link "Contact Us"
      current_path.should eq contact_us_path
    end
    # Contact Us page 5.1.4.7
    it "click Login" do
      click_link "Login"
      current_path.should eq new_user_session_path
    end
  end

#    /////////////////////////////////static pages testing ends here///////////////////////////////////

end
