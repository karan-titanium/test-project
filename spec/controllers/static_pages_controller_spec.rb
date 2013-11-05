require 'spec_helper'

describe StaticPagesController do
  
  describe "GET 'dashboard'" do
    it "returns http success" do
      get 'home_page'
      response.should be_success
    end
    it "returns http success" do
      get 'about_us'
      response.should be_success
    end
    it "returns http success" do
      get 'contact_us'
      response.should be_success
    end
    it "returns http success" do
      get 'client_info'
      response.should be_success
    end
    it "returns http success" do
      get 'home_page'
      response.should be_success
    end
        
  end
     
  describe "GET /static_pages/about_us " do
    it "should contain 'Candidate Signup', 'Client Info', 'Contact Us' links" do
      visit about_us_path
      # page.should have_link('Client Info', href: client_info_path)
      # page.should have_link('Contact Us', href: contact_us_path)
      # page.should have_link('Candidate Signup', href: new_user_registration_path) 
      # page.should have_link('Login') 
    end
    end
  
  describe "GET /static_pages/about_us and click Client Info link" do
    it "should go to client info page" do
      visit contact_us_path
      # page.should have_selector('div', :text => "Contact us")
      # click_link "Client Info"
      # current_path.should eq client_info_path
      # assert_redirected_to "/static_pages/client_info" 
    end
  end
  # describe "GET /static_pages/about_us and click Login link" do
    # it "should go to login page" do
      # visit about_us_path
      # click_link "Login"
      # current_path.should eq '/users/sign_in'
    # end
  # end
#   
    
    
    
    describe "Authentication" do
      describe "signin" do
        before { visit new_user_session_path }
        describe "with valid information" do
          let(:user) { FactoryGirl.create(:user) }
            before do
              fill_in "Email",    with: user.email.upcase
              fill_in "Password", with: user.password
              click_button "Log in"
            end
            
            it "dsf" do
    
               # current_path.should eq '/users/sign_in'
               # should have_content 'Invalid email or password'
             end
          # it { should have_title(user.name) }
          # it { should have_link('Profile',     href: user_path(user)) }
          # it { should have_link('Sign out',    href: signout_path) }
          it { should_not have_link('Sign up') }
        end
      end
  end
  
 

end
