class RegistrationsController < Devise::RegistrationsController

  layout "login_layout" 
  #before_filter :load_and_authorize_resource
  #before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error
=begin
 Objective:
 This method is used for sign up the use and set user log in log_system table 

 Input: confirmation token
 
 Output: redirects user to dashboard
  
 Logic:
 (this is method overriding of devise method done for adding log of user to log_system table)
 
=end 
  
  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        @log_msg = "User Signed Up through TFP UI, user status 'pending'"
        @log = LogSystem.create(:event_type => "user_event", :user_id => resource.id, :ip => request.remote_ip, :controller => self.controller_name, :action => self.action_name, :message => @log_msg)
        redirect_to signup_confirmation_path and return
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
      flash[:confirm_notice] = "Sign Up success"
      # sets user log with message in log_system table
      @log_msg = "User Signed Up through TFP UI, user status 'pending'"
      @log = LogSystem.create(:event_type => "user_event", :user_id => resource.id, :ip => request.remote_ip, :controller => self.controller_name, :action => self.action_name, :message => @log_msg)
      
    else
      clean_up_passwords resource
      respond_with resource
    end
        
  end
  
  def edit
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_password_resource(resource, params)
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  protected
  
  # This is devise inherited method used for create action
  def sign_up_params
    # devise_parameter_sanitizer.sanitize(:sign_up)
  end
  
  # This is devise inherited method used for create action takes user as input and,
  # redirects user after confirmation 
  def after_inactive_sign_up_path_for(resource)
    redirect_to signup_confirmation_path and return
  end
 
  def update_password_resource(resource, params)
    resource.update_attributes(params[:user])
  end
end
