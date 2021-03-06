class ServicesController < ApplicationController
  # before_filter :load_and_authorize_resource
  # before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error
  
  # before_filter :authenticate_user!
  
  layout "application"

=begin
  Objective : this method manages users logging in and signing up from Linkedin and Google 
  this action adds user data from provider(Linkedin/Google) to the database and creates users if he is registering(sign up) 
  else if user is present already then log in that user to the application
  
  Input : 
   
  Output :
  
  Logic : omniauth object is present when we are returning from authentication of provider
          this object is hash which contains data from the provider 
=end
  def create
    omniauth = request.env['omniauth.auth']

    if omniauth && omniauth['provider'] =='facebook' || omniauth['provider'] == 'linkedin' || omniauth['provider'] == 'google'

      # new_provider
      if Service.where(:uid => omniauth['uid'], :provider => omniauth['provider']).empty?

        # user_present_for_new_provider(login_with_provider_creation)
        if (user = User.find_by_email(omniauth['info']['email'])).present?
          user.services << Service.create(:provider => omniauth['provider'], :uemail => omniauth['info']['email'], :uid => omniauth['uid'], :uname => omniauth['info']['name']) 
          create_log_and_redirect user, omniauth['provider']
       
        # no_user_for_new_provider(new_signup)         
        else
          if omniauth['provider'] == 'google'
            name = omniauth['info']['name'].split(' ')
            user = User.create(:first_name => name.first, :last_name => name.last, :email => omniauth['info']['email'], :user_type => USER_TYPE_CONTACT, :status => USER_STATUS_PENDING, :password => Devise.friendly_token[0,20])
          else
            user = User.create(:first_name => omniauth['info']['first_name'], :last_name => omniauth['info']['last_name'], :email => omniauth['info']['email'], :user_type => USER_TYPE_CONTACT, :status => USER_STATUS_PENDING, :password => Devise.friendly_token[0,20])
          end  
          @log_msg = "User Signed Up through '" + omniauth['provider'] + "' user status 'pending'" 
          @log = LogSystem.create(:event_type => "user_event", :user_id => user.id, :ip => request.remote_ip, :controller => self.controller_name, :action => self.action_name, :message => @log_msg)
          user.services << Service.create(:provider => omniauth['provider'], :uemail => omniauth['info']['email'], :uid => omniauth['uid'], :uname => omniauth['info']['name'])
          flash[:notice] = t("devise.registrations.signed_up_but_unconfirmed")
          redirect_to signup_confirmation_path and return
          # create_log_and_redirect user, omniauth['provider']
        end
        
      # provider_present_in_db(simple_login)
      else
        user = Service.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first.user
        create_log_and_redirect user, omniauth['provider']
      end
      # if request is from unknown provider
    else         
      render :text =>  "not supported omniauth provider : " + ( omniauth ? omniauth['provider'] : " error in omniauth ") 
    end      

  end
  
  
  protected
  
  # Objective: Make a log for login user
  # Input: user object which is login in and provider with witch user is login
  # Output: user redirected depending on status
  # Logic: Redirect pending, deleted and inactive user to the login page  
  def create_log_and_redirect user, provider
    @log_msg = ( "User Login through " + provider ) if user.active_for_authentication?
    sign_in_and_redirect(:user, user)    
  end
  
end
