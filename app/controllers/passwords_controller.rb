# This controller is inherited from Devise::PasswordsController for changing default behaviour or add some extra functionality
class PasswordsController < Devise::PasswordsController

layout "login_layout"   
=begin
 Objective:
 This method is used while resetting password through reset password link and redirects user to the login page
 Input:
 password, confirm_password, current_password 
 
 Output:
 password
 
 Logic:
 (this is method overriding of devise method done for changing default redirect after password reset)
 takes password, confirm_password and current_password from user matches with current password and change password 
 after change password it redirects to login page with message 
 
=end  

  
  
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      # sign_in(resource_name, resource) #if want to login user after resetting password
      respond_with resource, :location => after_resetting_password_path_for(resource)
      @log_msg = "Password reset by user by clicking link send in email"
      @log = LogSystem.create(:event_type => "user_event", :user_id => resource.id, :ip => request.remote_ip, :controller => self.controller_name, :action => self.action_name, :message => @log_msg)
    else
      respond_with resource
    end
  end
  
  # This method creates password reset for user 
  # (this is method overriding of devise method done for changing default redirect after reset password link send to user)
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
    else
      flash[:alert]="email is not present with TFP" if resource.errors.messages[:email][0].present?
      redirect_to new_user_session_path
      # respond_with(resource)
    end
  end
  
  protected
    
    # Objective: This method redirects user to login page after resetting password
    # Input: current_user
    # Output:
    # Logic: Redirect user to login after resetting password       
    def after_resetting_password_path_for(resource)
      new_session_path(resource) 
      # after_sign_in_path_for(resource)  #if want to login user after resetting password
    end 
  
end
