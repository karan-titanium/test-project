class UserProfilesController < ApplicationController
  #before_filter :load_and_authorize_resource
  #before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error
  
  after_filter :check_for_update
  # layout "candidate"
  require 'json' # Required to parse request parameters coming in JSON format for every action  
  before_filter :authenticate_user! # Checks whether User is authenticated before processing each action
  before_filter :set_user # Makes necessry set of variables available to each action
  respond_to :html, :only => :online_test
  include UsersHelper # This to use all method in user Helper available to UserProfile controller and and views
  
  # layout "candidate" , only: [:dashboard, :profile_summary]
  # layout "application", only: [:dashboard]
  
  
  #================================================================================================================
  # =>                                  For AutoComplete                                                
  #================================================================================================================
  
  # auto complete for qualification type it will auto generate autocomplete_qualification_type_name action
  # autocomplete :qualification_type, :name  
  # auto complete for School/location  it will auto generate autocomplete_qualification_location_name action
  # autocomplete :qualification_location, :name
  # auto complete for subject  it will auto generate autocomplete_qualification_subject_name action
  # autocomplete :qualification_subject, :name
  # auto complete for It Skill  it will auto generate autocomplete_itskill_name action
  # autocomplete :itskill, :name
  # auto complete for comapny it will auto generate autocomplete_company_name action
  # autocomplete :company, :name
  
  
  #================================================================================================================
  # objective: to show candidate dashboard page after login 
  # inputs: user object
  # output: it redirected to dashboard page with user object 
  #================================================================================================================

  def dashboard
    user_profile_is_complete? @user 
    @profile_photo = @user.cdn_files.build
    
    @user_exams = @user.user_exams.where("status =?", 'pending')
    @user_campaigns = @user.user_campaigns
    
    @log_msg = "after login or page refresh request user came on dashboard"      #log message
  end

  #================================================================================================================
  # objective: to check user profile is completely field or not and set in session variable  
  # inputs: user object
  # output: it set session variable is_profile_complete
  #================================================================================================================
  
  def user_profile_is_complete?(user)
    if !work_eligibility_completely_filled? user
        session[:is_profile_complete] = false      
    elsif !personal_details_completely_filled? user
        session[:is_profile_complete] = false
    elsif !employment_details_completely_filled? user
        session[:is_profile_complete] = false
    elsif !upload_cv_completely_filled? user
        session[:is_profile_complete] = false
    elsif !online_test_completely_filled? user
        session[:is_profile_complete] = false
    elsif !qualification_completely_filled? user
        session[:is_profile_complete] = false
    elsif !skills_completely_filled? user
        session[:is_profile_complete] = false
    else
        session[:is_profile_complete] = true
    end    
  end

  #================================================================================================================
  # objective: to render user to user profile summary page 
  # inputs: user object
  # output: user object make available to summary page
  #================================================================================================================

  def summary
    if params[:user_profile].present?
      @user.user_profile.update_attributes(params[:user_profile])  
      (@user.last_updated_at < @user.user_profile.updated_at) ? (@user.update_attributes(:last_updated_at => @user.user_profile.updated_at) ) : "" 
    end
    
    user_profile_is_complete? @user
    
    @user_exams = @user.user_exams.where("status =?", 'pending')
    @user_campaigns = @user.user_campaigns    
    
    @log_msg = "on finish button click on skill page or summary navigation tab clcik"      #log message 
    render :partial =>'summary'
  end

  #================================================================================================================
  # objective: to render user to work_eligibility page  
  # inputs: user object
  # output: user object make available to work_eligibility page 
  #================================================================================================================

  def work_eligibility
    @log_msg = "on next button click on summary page or work eligibility navigation tab clcik"      #log message
    render :partial =>'work_eligibility'
  end


  #================================================================================================================
  # objective: to render user to personal_details page and save details from previous page  
  # inputs: user object
  # output: user object make available to personal_details page
  #================================================================================================================
  def personal_details
    @log_msg = "work eligibility form data " + params[:user].to_s if params[:user].present?
    render :partial =>  (@user.update_attributes(params[:user]) ? 'personal_details' : 'work_eligibility')
  end

  #================================================================================================================
  # objective: to render user to employemnt_details page and save details from previous page  
  # inputs: user object
  # output: make @user_company and @user object available to employment_details page
  #================================================================================================================

  def employment_details
    @user.user_profile.contact_time = params[:contact_time] if !params[:contact_time].nil?
    render :partial => ( ( @user.update_attributes(params[:user]) ) ? 'employment_details' : 'personal_details' )
    
    @log_msg = "data from personal details form "+ params[:user].to_s if params[:user].present? 
  end

  #================================================================================================================
  # objective: to render user to upload_cv page and save details from previous page   
  # inputs: user object
  # output: user object make available to personal_details page
  #================================================================================================================

  def upload_cv
    
    render :partial => ( @user.user_profile.update_attributes( params[:user].present? ? params[:user][:user_profile_attributes] : nil ) ? 'upload_cv' : 'employment_details')
    if @user.user_profile.employed == "no"
      user_comp = @user.user_companies.where(:current => true).first
      user_comp.update_attributes(:current => false) if user_comp.present?
    end
    
    @log_msg = "data from employment details form " + params[:user][:user_profile_attributes].to_s if params[:user].present? 
    return 
  end

  #================================================================================================================
  # objective: to render user to online test page and save details from previous page i.e cv if uploaded by user   
  # inputs: user object and file if uploaded by user
  # output: save uploaded file and render user to online test page with user object
  #================================================================================================================

  def online_test
    @cdn_file = @user.cdn_files.build(params[:cdn_file]) if (params[:cdn_file].present? && params[:cdn_file][:cf_filename].present?)
    if @cdn_file.present? && @cdn_file.save
      @user.user_files.build(:cdn_file_id => @cdn_file.id, :user_file_type => "cv") if params[:cdn_file].present?
      @user.save
      
      @log_msg = "cdn file object from upload cv  "+ params[:cdn_file].to_s
    end
    @user_exams = @user.user_exams.where("status !=?", 'deleted')
      respond_to do |format| format.js end
  end
  
  
  def online_test_link_click
    @user_exams = @user.user_exams.where("status !=?", 'deleted')
    return render :partial => 'online_test', :locals => {:user_exams => @user_exams}
  end
  #================================================================================================================
  # objective: redirect user to qualification page and save all updated info of user if user come from online-test page 
  # inputs:  user object
  # output: render to skills partial with all user_qualifiactions, all QulaificationGrades, and empty object of user_qualification and qualification_type
  #================================================================================================================
  def qualifications
    @user_qualifications = @user.user_qualifications.all
    @grades = QualificationGrade.where(:status => 'active')
   
    @log_msg = "user render to qualifications page"   
    render :partial => 'qualifications', :locals => {:user_qualifications => @user_qualifications, :grades => @grades, :submit_button_clicked_id => params[:commit]}
  end

  #================================================================================================================
  # objective: redirect user to skill page with all users skills
  # inputs:  user object
  # output: render to skills partial with @user_it_skills, @user_other_skills, @user_languages,@languages,
  #          @user_it_skill, @user_other_skill, @user_language to make available to skill page
  #================================================================================================================
  def skills
    @user_it_skills = @user.user_itskills
    @user_other_skills = @user.user_otherskills
    @user_languages = @user.user_languages
    @languages = Language.where(:status => 'active')
    
    @log_msg = "user come on skills page by clicking either skill nevigation tab or next button on qualification page"
    render :partial =>'skills', :locals => {:user => @user, :user_it_skills => @user_it_skills, :user_other_skills => @user_other_skills, :user_languages => @user_languages, :languages => @languages}
  end
  
  #================================================================================================================
  # objective: to add user_qualification
  # inputs: user_qulification object to add and user object
  # output: it return nothing
  #================================================================================================================
  def add_qualification
    @user.user_qualifications.build(params[:user_qualification]) 
    @user.save
    @log_msg = "new qualification added is "+ (params[:user_qualification].present? ? params[:user_qualification].to_s : "") 
    
    @user_qualifications = @user.user_qualifications.all
    @grades = QualificationGrade.where(:status => 'active')
    
    partial_locals = {:user_qualifications => @user_qualifications, :grades => @grades }
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "qualifications", :partial_locals => partial_locals, :modal_id => "qualificationbuilder", :button_caption => params[:commit] } 
    
    (@user.last_updated_at < (quali = @user.user_qualifications.where('id IS NOT NULL').last ).created_at) ? (@user.update_attributes(:last_updated_at => quali.created_at ) ) : "" if (@user.present? && @user.user_qualifications.where('id IS NOT NULL').present?)
  end

  #================================================================================================================
  # objective: to remove user_qualification
  # inputs: user_qulification_id which have to remove and user object
  # output: it return nothing
  #================================================================================================================

  def remove_qualification
    quali = UserQualification.where(:id => params[:qualiID]) 
    quali.destroy_all if quali.present?
    @user.save
    @log_msg = "qualification removed is "+ (quali.present? ? quali.to_s : "")
    render nothing: true
  end 

  #================================================================================================================
  # objective: to add user_itskills
  # inputs: user_itskill object info from user in params[:user_itskill]
  # output: it return nothing    
  #================================================================================================================

  def add_it_skill
    user_it_skill = @user.user_itskills.build(params[:user_itskill])
    user_it_skill.experience = user_it_skill.experience * 12 if (params[:it_experience_type].present? && params[:it_experience_type].casecmp("year") == 0)
    @user.save
    
    @log_msg = "new user_itskill added is "+ (params[:user_itskill].present? ? params[:user_itskill].to_s : "")
    
    @user_it_skills = @user.user_itskills
    @user_other_skills = @user.user_otherskills
    @user_languages = @user.user_languages
    @languages = Language.all
    
    partial_locals = {:user => @user, :user_it_skills => @user_it_skills, :user_other_skills => @user_other_skills, :user_languages => @user_languages, :languages => @languages}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "skills", :partial_locals => partial_locals, :modal_id => "itskill", :button_caption => params[:commit] }
    
   (@user.last_updated_at < ( itskill = @user.user_itskills.where('id IS NOT NULL').last).created_at) ? (@user.update_attributes(:last_updated_at => itskill.created_at ) ) : "" if (@user.present? && @user.user_itskills.where('id IS NOT NULL').present?)
  end

  #================================================================================================================
  # objective: to add user_otherskills
  # inputs: user_otherskill object info from user in params[:user_otherskill]
  # output: it return nothing
  #================================================================================================================
  def add_other_skill
    user_other_skill = @user.user_otherskills.build(params[:user_otherskill])
    user_other_skill.experience = user_other_skill.experience * 12 if (params[:other_experience_type].present? && params[:other_experience_type].casecmp("year") == 0)
    @user.save
    
    @log_msg = "new user_otherskill added is "+ (params[:user_otherskill].present? ? params[:user_otherskill].to_s : "")
    
    @user_it_skills = @user.user_itskills
    @user_other_skills = @user.user_otherskills
    @user_languages = @user.user_languages
    @languages = Language.all
    
    
    partial_locals = {:user => @user, :user_it_skills => @user_it_skills, :user_other_skills => @user_other_skills, :user_languages => @user_languages, :languages => @languages}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "skills", :partial_locals => partial_locals, :modal_id => "otherskills", :button_caption => params[:commit] }
    
    (@user.last_updated_at < ( otherskill = @user.user_otherskills.where('id IS NOT NULL').last).created_at) ? (@user.update_attributes(:last_updated_at => otherskill.created_at) ) : "" if (@user.present? && @user.user_otherskills.where('id IS NOT NULL').present?)
  end

  #================================================================================================================
  # objective: to add user_language
  # inputs: user_language object info from user in params[:user_language]
  # output: it return nothing
  #================================================================================================================
  def add_language
    user_language = @user.user_languages.build(params[:user_language])
    @user.save
    
    @log_msg = "new user_language added is "+ (params[:user_language].present? ? params[:user_language].to_s : "")
    
    @user_it_skills = @user.user_itskills
    @user_other_skills = @user.user_otherskills
    @user_languages = @user.user_languages
    @languages = Language.all
    
    partial_locals = {:user => @user, :user_it_skills => @user_it_skills, :user_other_skills => @user_other_skills, :user_languages => @user_languages, :languages => @languages}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "skills", :partial_locals => partial_locals, :modal_id => "language", :button_caption => params[:commit] }
    
    (@user.last_updated_at < ( lang = @user.user_languages.where('id IS NOT NULL').last).created_at) ? (@user.update_attributes(:last_updated_at => lang.created_at) ) : "" if (@user.present? && @user.user_languages.where('id IS NOT NULL').present?)
  end


  #================================================================================================================
  # objective: to remove user_itskills
  # inputs: user object with user_itskill id to be removed
  # output: it return nothing
  #================================================================================================================
  
  def remove_it_skill
    itskill = UserItskill.find(params[:item_id])
    itskill.destroy if itskill.present?
    
    @log_msg = 'user_itskill removed '+ (itskill.present? ? itskill.to_s : '' )
    
    render nothing: true
  end
  
  #================================================================================================================
  # objective: to remove user_otherskills
  # inputs: user object with user_otherskill id to be removed
  # output: it return nothing
  #================================================================================================================
  
  def remove_other_skill
    otherskill = UserOtherskill.find(params[:item_id])
    otherskill.destroy if otherskill.present?
    
    @log_msg = 'user_otherskill removed '+ (otherskill.present? ? otherskill.to_s : '' )
    
    render nothing: true
  end
  
  #================================================================================================================
  # objective: to remove user_language
  # inputs: user object with user_language id to be removed
  # output: it return nothing
  #================================================================================================================
  def remove_language
    ur_lang = UserLanguage.find(params[:item_id])
    ur_lang.destroy if ur_lang.present?
    
    @log_msg = 'user_language removed '+ (ur_lang.present? ? ur_lang.to_s : '' )
    
    render nothing: true
  end
  

  #================================================================================================================
  # objective: to add user_profile_photo
  # inputs: cdn_file object and user object
  # output: it render to crop page
  #================================================================================================================

  def upload_profile_photo
    user_profile = @user.user_profile
    if user_profile.photo.present?
      CdnFile.find(user_profile.photo).destroy
    end
    @cdn_file = @user.cdn_files.build(params[:cdn_file]) if params[:cdn_file].present?
    # @cdn_file.file_type = 'image' if @cdn_file.present?
    if @cdn_file.present? && @cdn_file.save
       @user.user_files.build(:user_file_type => "other", :cdn_file_id => @cdn_file.id)
       @user.user_profile.photo = @cdn_file.id
       @user.save
       respond_to do |format| format.js  end # it will be render to upload_profile_photo.js.erb
    end
    
  end

  #================================================================================================================
  # objective: to add user_company
  # inputs: user object and user_company object
  # output: it render nothing 
  #================================================================================================================
  def add_user_company
    @user.user_companies.build(params[:user_company])
    @log_msg = "new user_company added is "+ (params[:user_company].present? ? params[:user_company].to_s : "")
    @user.save
    
    partial_locals = {:user_company => @user_company}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "employment_details", :partial_locals => partial_locals, :modal_id => "employerbuilder", :button_caption => params[:commit] }
    
    (@user.last_updated_at < (u_comp = @user.user_companies.where('id IS NOT NULL').last).created_at) ? (@user.update_attributes(:last_updated_at => u_comp.created_at) ) : "" if (@user.present? &&  @user.user_companies.where('id IS NOT NULL').present?)
  end

  
  #================================================================================================================
  # objective: to update until date for user company
  # inputs: user_comany
  # output: nothing  
  #================================================================================================================
  def update_user_company
    uc = UserCompany.find params[:user_company_id]
    uc.update_attributes(params[:user_company])
    
    @user.user_profile.update_attributes(:employed => "no" )
    
    partial_locals = {:user_company => @user_company}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "employment_details", :partial_locals => partial_locals, :modal_id => "employerbuilder", :button_caption => params[:commit] }
  end
  #================================================================================================================
  # objective: to redirect candidate to incomplete section
  # inputs: user object 
  # output: user redirected to action  
  #================================================================================================================

  def complete_profile
    if ! work_eligibility_completely_filled? @user
       redirect_to '/user_profiles/work_eligibility'     
    elsif !personal_details_completely_filled? @user
       redirect_to '/user_profiles/personal_details' 
    elsif !employment_details_completely_filled? @user
       redirect_to '/user_profiles/employment_details' 
    elsif !upload_cv_completely_filled? @user
       redirect_to '/user_profiles/upload_cv' 
    elsif !online_test_completely_filled? @user
       redirect_to '/user_profiles/online_test' 
    elsif !qualification_completely_filled? @user
       redirect_to '/user_profiles/qualifications' 
    elsif !skills_completely_filled? @user
       redirect_to '/user_profiles/skills' 
    end    
  end
  
  #================================================================================================================
  #================================================================================================================

  def set_user
      if current_user
        @user = current_user
        @user.user_profile ||= @user.build_user_profile 
      end
      
      @path = {:summary => user_profiles_summary_path, 
                :work_eligibility => user_profiles_work_eligibility_path,
                :personal_details => user_profiles_personal_details_path,
                :employment_details => user_profiles_employment_details_path,
                :upload_cv => user_profiles_upload_cv_path,
                :online_test => user_profiles_online_test_path,
                :qualifications => user_profiles_qualifications_path,
                :skills => user_profiles_skills_path,
                :online_test_side_link => user_profiles_online_test_link_click_path
        }
  
  end
  
  
  #================================================================================================================
  # objective: to crop image
  # inputs: image object with crop_x, crop_y, crop_w, crop_h, coords
  # output: it render nothing 
  #================================================================================================================
  def crop_image
    c = CdnFile.find(params[:file_id])
    c.update_attributes(params[:cdn_file])
    render :partial =>'profile_photo', :locals => {:user => @user}
  end
  
   #================================================================================================================
  # =>                                  For AutoComplete                                                
  #================================================================================================================
  
  
  #================================================================================================================
  # objective: AutoComplete for qualification type which returns only status active qualification type
  # inputs: params variable terms which contain user input string
  # output: it return chars matching qualification type name 
  #================================================================================================================
  def autocomplete_qualification_type_name
    term = params[:term]
    if term && !term.empty?
        active_qualification_type = QualificationType.where(:status => "active")
        items = active_qualification_type.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  
  #================================================================================================================
  # objective: AutoComplete for qualification location which returns only status active location 
  # inputs: params variable terms which contain user input string
  # output: it return chars matching qualification location name 
  #================================================================================================================
  def autocomplete_qualification_location_name
    term = params[:term]
    if term && !term.empty?
        active_qualification_loc = QualificationLocation.where(:status => "active")
        items = active_qualification_loc.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  #================================================================================================================
  # objective: AutoComplete for qualification subject which returns only status active qualification subject
  # inputs: params variable terms which contain user input string
  # output: it return chars matching qualification subject name 
  #================================================================================================================
  def autocomplete_qualification_subject_name
    term = params[:term]
    if term && !term.empty?
        active_qualification_subject = QualificationSubject.where(:status => "active")
        items = active_qualification_subject.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  #================================================================================================================
  # objective: AutoComplete for It Skill which returns only status active It skill name
  # inputs: params variable terms which contain user input string
  # output: it return chars matching it skills name 
  #================================================================================================================
  def autocomplete_itskill_name
    term = params[:term]
    if term && !term.empty?
        active_itskills = Itskill.where(:status => "active")
        items = active_itskills.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  
  #================================================================================================================
  # objective: AutoComplete for Company which returns only status active company
  # inputs: params variable terms which contain user input string
  # output: it return chars matching company name 
  #================================================================================================================
  def autocomplete_company_name
    term = params[:term]
    if term && !term.empty?
        active_company = Company.where(:status => "active")
        items = active_company.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  # def dowload_cv
    # (user_files = @user.user_files.where(:user_file_type => "cv")).present?
    # cdn_file = user_files.last.cdn_file
    # send_file cdn_file.cf_filename_url
  # end
  
  
  #================================================================================================================
  # objective: To check if any changes made by current user
  # inputs: all params object
  # output: if any changes than current date added to user model in last_updated_date attributes 
  #================================================================================================================
  def check_for_update
    # (@user.last_updated_at < @user.user_profile.updated_at) ? (@user.update_attributes(:last_updated_at => @user.user_profile.updated_at) ) : "" if @user.present? && @user.user_profile.updated_at.present?
    (@user.last_updated_at < ( user_file = @user.user_files.where('id IS NOT NULL').last ) .created_at) ? (@user.update_attributes(:last_updated_at => user_file.created_at ) ) : "" if (@user.present? && @user.user_files.where('id IS NOT NULL').present?)
  end
  
  
  #================================================================================================================
  # objective: To Change password
  # inputs: user object 
  # output: change password  
  #================================================================================================================
  def update_password
    if @user.update_attributes(params[:user])
      sign_in(@user, :bypass => true)
    end   
    flash[:notice] = t('devise.passwords.updated')
    @profile_photo = @user.cdn_files.build
    if request.xhr?
      return render :partial => '/user_profiles/password_changed'     
    else
      redirect_to :back
    end
    
  end
end
