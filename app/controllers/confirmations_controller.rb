class ConfirmationsController <  Devise::ConfirmationsController
  # before_filter :load_and_authorize_resource
  # before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error

=begin
 Objective:
 This method is used after confirmation link is clicked and redirects user to dashboard

 Input: confirmation token
 
 Output: redirects user to dashboard
  
 Logic:
 (this is method overriding of devise method done for adding log of user to log_system table)
 
=end  

  layout "login_layout" 
  
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      respond_with_navigational(resource){ after_confirmation_path_for(resource_name, resource) }
      @log_msg = "User confirmed account by clicking link in email, user status 'active'"
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end
  
  protected
   # This method sign in user and redirect user to its path ( dashboard )
    def after_confirmation_path_for(resource_name, resource)
      # after_sign_in_path_for(resource)
      sign_in_and_redirect(:user, resource)
    end


end
