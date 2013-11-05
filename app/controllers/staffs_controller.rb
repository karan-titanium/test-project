class StaffsController < ApplicationController
  #before_filter :load_and_authorize_resource
  #before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error

  include StaffsHelper
  before_filter :authenticate_user!
  
 def show
   
 end
#######################################################################################################################
# Objective: TODO: 
# Input:
# Output:
#######################################################################################################################  
  def dashboard
    #@candidates_with_incomplete_profile = User.candidates     #TODO: correct query
    session[:page_title] = session[:tab_title] = "Staff Dashboard"
    
    @unconfirmed_companies = Company.where(:status => COMPANY_STATUS_UNCONFIRMED)
    @unconfirmed_qualification_types = QualificationType.where(:status => QUALIFICATION_STATUS_UNCONFIRMED)
    @unconfirmed_qualification_locations = QualificationLocation.where(:status => QUALIFICATION_LOCATION_STATUS_UNCONFIRMED)
    @unconfirmed_qualification_subjects = QualificationSubject.where(:status => QUALIFICATION_SUBJECT_STATUS_UNCONFIRMED)
    @unconfirmed_qualification_grades = QualificationGrade.where(:status => QUALIFICATION_GRADE_STATUS_UNCONFIRMED)
    @unconfirmed_itskills = Itskill.where(:status => IT_SKILL_STATUS_UNCONFIRMED)
    @unconfirmed_languages = Language.where(:status => LANGUAGE_STATUS_UNCONFIRMED)
    
    @count = [@unconfirmed_companies.count, @unconfirmed_qualification_types.count, @unconfirmed_qualification_locations.count, @unconfirmed_qualification_subjects.count, @unconfirmed_qualification_grades.count, @unconfirmed_itskills.count, @unconfirmed_languages.count].max
    
  end

#######################################################################################################################
# Objective: To represent Staff User Setting page (5.5.2)
# Input: 
# Output: Redirected to Setting page 
#######################################################################################################################  
  def settings
    session[:page_title] = session[:tab_title] = "Staff Settings"
  end
  


#######################################################################################################################
# Objective: To load the contents of 'My Details' tab (5.5.2.1)
# Input:
# Output: Renders a partial with the contents of 'My Details' tab
#######################################################################################################################  
  def my_details
    render :partial => "my_details", :locals => { :staff_user => current_user }
    return
  end
  


#######################################################################################################################
# Objective: To load the contents of 'Manage Users' tab (5.5.2.2)
# Input:
# Output: Renders a partial with the contents of 'Manage Users' tab
#######################################################################################################################  
  def manage_users
    render :partial => "manage_users", :locals => { :staff_users => User.staff_users }
    return
  end
  


#######################################################################################################################
# Objective: To load the contents of 'Manage Roles' tab (5.5.3)
# Input:
# Output: Renders a partial with the contents of 'Manage Roles' tab
#######################################################################################################################  
  def manage_roles
    render :partial => "manage_roles", :locals => { :roles => Role.all, :permissions => Permission.all }
    return
  end
  


#######################################################################################################################
# Objective: To load the contents of 'System Config' tab (5.5.3.1)
# Input:
# Output: Renders a partial with the contents of 'System Config' tab
#######################################################################################################################  
  def system_config
    render :partial => "system_config", :locals => { :system_settings => SystemSetting.editable_settings, :setting_categories => SettingCategory.all }
    return  
  end



#######################################################################################################################
# Objective: To create a new staff user
# Input: params[:user]
# Output: Creates a new staff user with 'active' status, makes an entry for event log & reloads the contents of 'Manage Users' tab 
#######################################################################################################################  
  def create_user
    if params[:user].present?
      new_user = User.new(params[:user])
      new_user.skip_confirmation!
      
      if new_user.save
        flash[:notice] = "Staff user added successfully..."   #TODO: fetch msg from DB
        @log_msg = "New User " + new_user.id.to_s + " added"
      end  
    end
    
    render :partial => "manage_users", :locals => { :staff_users => User.staff_users }
    return
  end
  


#######################################################################################################################
# Objective: To set/change the status of staff user
# Input: params[:u_id], params[:status]
# Output: Sets the user status to value of params[:status], makes an entry for event log & reloads the contents of 'Manage Users' tab
#######################################################################################################################  
  def set_user_status
    if params[:u_id].present? && params[:status].present?
      User.find(params[:u_id]).update_attributes(:status => params[:status])
      params[:status].casecmp(USER_STATUS_DELETED) == 0 ? (@log_msg = "user " + params[:u_id] + " deleted") : (@log_msg = "user " + params[:u_id] + " status updated to " + params[:status])
    end 
    
    render :partial => "manage_users", :locals => { :staff_users => User.staff_users }
    return  
  end



#######################################################################################################################
# Objective: To save the details of logged in staff user
# Input: params[:u_id], params[:user]
# Output: Saves the details of logged in staff user, makes an entry for event log & reloads the contents of 'My Details' tab
#######################################################################################################################  
  def save_my_details
    save_user_details(params)
    
    render :partial => "my_details", :locals => { :staff_user => User.find(current_user.id) }
    return
  end
  


#######################################################################################################################
# Objective: To save the details of a staff user
# Input: params[:u_id], params[:user]
# Output: Saves the details of a staff user, makes an entry for event log & reloads the contents of 'Manage Users' tab
#######################################################################################################################  
  def edit_user
    save_user_details(params)

    render :partial => "manage_users", :locals => { :staff_users => User.staff_users }
    return
  end
  


#######################################################################################################################
# Objective: To update the contents of System setting passed in params 
# Input: params[:s_id], params[:system_setting]
# Output: Updates the contents of System setting passed in params, makes an entry for event log & reloads the contents of 'System Config' tab
#######################################################################################################################  
  def update_system_setting
    @log_msg = params[:system_setting][:name].to_s + " value changed"  if params[:s_id].present? && params[:system_setting].present? && SystemSetting.find(params[:s_id]).update_attributes(params[:system_setting])
    Settings.reload!    # To reload system_settings.yml file 
    
    render :partial => "system_config", :locals => { :system_settings => SystemSetting.editable_settings, :setting_categories => SettingCategory.all }, :content_type => 'text/html'
    return
  end
  
  

#######################################################################################################################
# Objective: To create a new role with details passed in params
# Input: params[:role]
# Output: Create a new role with details passed in params, makes an entry for event log & reloads the contents of 'Manage Roles' tab 
#######################################################################################################################  
  def create_role
   if params[:role].present?
     new_role = Role.create(params[:role])
     @log_msg = "new role " +  new_role.id.to_s + " added"
   end

   render :partial => "manage_roles", :locals => { :roles => Role.all, :permissions => Permission.all }
   return 
  end
  

  
  private
#######################################################################################################################
# Objective: Internal method to save the details of a user
# Input: params => params[:u_id], params[:user]
# Output: Saves the details of User passed in params, makes an entry for event log & return the control back 
#######################################################################################################################  
  def save_user_details(params)
    if params[:u_id].present? && params[:user].present? 
      user = User.find(params[:u_id])
      
      if user.update_attributes(params[:user].delete_if {|k,v| !v.present?})
        sign_in(current_user, :bypass => true)
        flash[:notice] = "Details updated successfully..."    #TODO: fetch msg from DB
        @log_msg = "user " + user.id.to_s + " [first name / last name / email address / password] updated"
      end
    end
  end
  
  
end
