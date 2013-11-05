class ApplicationController < ActionController::Base
  protect_from_forgery

  #rescue_from CanCan::AccessDenied do |exception|
  #  flash[:notice] = "Access denied. You are not authorized to access the requested page."
  #  redirect_to root_path and return
  #end
 
  after_filter :add_log
  
  def add_log
    if @log_msg != nil
      @log = LogSystem.create(:event_type => "user_event", :user_id => current_user.id, :ip => request.remote_ip, :controller => self.controller_name, :action => self.action_name, :message => @log_msg) if current_user
    end
    # @version  = Version.last
    # binding.pry
  end 


  protected
 
  #derive the model name from the controller. egs UsersController will return User
  def self.permission
    #return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
    return name = self.name.gsub('Controller','').singularize.split('::').last
  end
 
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
 
  #load the permissions for the current user so that UI can be manipulated
  def load_permissions
    @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
  end

end
