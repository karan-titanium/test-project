class ContactsController < ApplicationController
  
  before_filter :set_user, :except => "test_action" # Makes necessry set of variables available to each action
  
#=====================================================================================
#
#
#
#=====================================================================================  
  
  def index
    @contacts = User.where(:user_type => USER_TYPE_CONTACT)
  end

#=====================================================================================
#
#
#
#=====================================================================================
  
  def show
    @contact = User.find(params[:id])
  end

#=====================================================================================
#
#
#
#=====================================================================================
  
  def new
      render :partial => 'new_contact'
  end

#=====================================================================================
#
#
#
#=====================================================================================
  
  def create_contact
    if params[:user].present?
      new_user = User.new(params[:user])
      new_user.skip_confirmation!
      if new_user.save
        UserMailer.welcome_email(new_user.email).deliver  if params[:welcome_email] == "true"
        @log_msg = "Contact " + new_user.id.to_s + " created by user " + current_user.id.to_s
      end
    end
    
    redirect_to action: "index"
  end
  
#=====================================================================================
#
#
#
#=====================================================================================
  def update_status
    if params[:user].present?
     contact = User.find(params[:contact_id])
     contact.update_attributes(params[:user])
    end
    render nothing: true
  end
#=====================================================================================
#
#
#
#=====================================================================================

  def update_contact
    
    if params[:user].present?
      contact = User.find(params[:contact_id])
      contact.update_attributes(params[:user])
    end
    # binding.pry
    contact_campaigns = contact.user_campaigns if contact.present?
    # binding.pry
    partial_locals = {:contact => contact, :contact_campaigns => contact_campaigns}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "overview", :partial_locals => partial_locals , :modal_id => "updatedetails", :button_caption => "" }
    
    # binding.pry
    # redirect_to action: "index"
   # redirect_to :partial => "overview", :locals => {:contact => contact, :contact_campaigns => contact_campaigns}    
  end
#=====================================================================================
#
#
#
#=====================================================================================
#=====================================================================================
#
#
#
#=====================================================================================
    
  def render_contact_profile_section
    if params[:contact_id].present? && params[:profile_section].present? 
      contact = User.find(params[:contact_id])
      if contact.present?
        non_applied_active_campaigns = contact.non_applied_active_campaigns
        contact_logs = ContactLog.where(:to => contact.id)
        contact_campaigns = contact.user_campaigns
        
        campaigns = contact.campaigns
        contact_interviews = Interview.where(:candidate => contact.id)
      end
      
      case params[:profile_section]
        when CANDIDATE_OVERVIEW
          binding.pry
          return render :partial => "overview", :locals => {:contact => contact, :contact_campaigns => contact_campaigns}
        when CANDIDATE_PROFILE
          return render :partial => "profile", :locals => {:contact => contact}
        when CANDIDATE_TRAITS
          user_traits = contact.user_traits
          @traits = Trait.where(:status => TRAIT_STATUS_INTERNAL)
          return render :partial => "traits", :locals => {:user_traits => user_traits, :contact => contact, :traits => @traits}
        when CANDIDATE_QUALIFICATION
          @grades = QualificationGrade.where(:status => 'active')   
          return render :partial => "qualifications", :locals => {:contact => contact, :grades => @grades}
        when CANDIDATE_CONTACT_LOG      
          return render :partial => "contact_log", :locals => {:contact_logs => contact_logs, :contact => contact, :campaigns => campaigns} 
        when CANDIDATE_CAMPAIGNS
          return render :partial => "campaigns", :locals => {:non_applied_active_campaigns => non_applied_active_campaigns, :contact_campaigns => contact_campaigns, :contact => contact}
        when CANDIDATE_INTERVIEWS
          return render :partial => "interviews", :locals => {:contact_interviews => contact_interviews, :contact => contact, :campaigns => campaigns}
        when CANDIDATE_EXAMS
          user_exams = contact.user_exams.includes(:exam).where('status =?', 'ended')
          return render :partial => "exams", :locals => { :user_exams => user_exams }        
      end
    end
  
  end  
  
#=====================================================================================
#=====================================================================================  
  def add_campaign
    user_campaign = UserCampaign.new(params[:user_campaign])
    user_campaign.save
    contact = User.find(user_campaign.user_id)
    if contact.present?
        non_applied_active_campaigns = contact.non_applied_active_campaigns
        contact_campaigns = contact.user_campaigns
    end
    
    partial_locals = {:non_applied_active_campaigns => non_applied_active_campaigns, :contact_campaigns => contact_campaigns, :contact => contact}
    return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "campaigns", :partial_locals => partial_locals , :modal_id => "link_to_campaign", :button_caption => "" }
  end
  
  
#=====================================================================================
#=====================================================================================  
 def create_contact_log
    new_contact_log = ContactLog.new(params[:contact_log])   if params[:contact_log].present?
    # new_contact_log.datecontact = User.find(new_contact_log.to).created_at   if new_contact_log.present?
    @log_msg = ""   if new_contact_log.save   #TODO:
    
    contact = User.find(new_contact_log.to)
    contact_logs = ContactLog.where(:to => contact.id)
    campaigns = contact.campaigns
    # return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "overview", :partial_locals => {}, :modal_id => "contactentry", :button_caption => params[:commit] }   if params[:from_page] == COMPANY_OVERVIEW
    return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "contact_log", :partial_locals => {:contact_logs => contact_logs, :contact => contact, :campaigns => campaigns }, :modal_id => "newcontactlog", :button_caption => params[:commit] }   # if params[:from_page] == COMPANY_CONTACT_LOG 
  end
  
#=====================================================================================
#=====================================================================================   
  def add_interview
    new_interview = Interview.create(params[:interview])
    
    contact = User.find(new_interview.candidate)
    campaigns = contact.campaigns
    contact_interviews = Interview.where(:candidate => contact.id)
    
    return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "interviews", :partial_locals => {:contact => contact, :campaigns => campaigns, :contact_interviews => contact_interviews}, :modal_id => "new_interview", :button_caption => params[:commit] }   # if params[:from_page] == COMPANY_CONTACT_LOG
  end
  
#=====================================================================================
# Objective => 
# Input => 
# Output =>
#=====================================================================================  
  def update_contact_profile
    contact = User.find(params[:contact_id])
    case params[:current_div]
      #======= for work eligibility =================      
        when "work_eligibility_div"
            contact.update_attributes(params[:user])
      #======= end work eligibility =================
                
      #======== for Employment details ==============        
        when "employment_details_div"
            contact.user_profile.update_attributes( params[:user].present? ? params[:user][:user_profile_attributes] : nil ) 
      #======== end for Employment details ==========
        
      #========== for cv ============================  
        when "cv_div"
            
      #============ end for Cv ======================
        
        
      #============== for it skills =================  
        when "itskills_div"
            user_it_skill = contact.user_itskills.build(params[:user_itskill])
            user_it_skill.experience = user_it_skill.experience * 12 if (params[:it_experience_type].present? && params[:it_experience_type].casecmp("year") == 0)
          
      #============== end of it skills================
      
      
      #============== for other skills ===============   
        when "otherskills_div"
            user_other_skill = contact.user_otherskills.build(params[:user_otherskill])
            user_other_skill.experience = user_other_skill.experience * 12 if (params[:other_experience_type].present? && params[:other_experience_type].casecmp("year") == 0)
      #============== end  for other skills ===========  
      
      
      #=============== for contact languages ==========  
        when "languages_div" 
            user_language = contact.user_languages.build(params[:user_language])
      #============== End for contact languages =======     
    end
    contact.save
    return render :partial => "profile", :locals => {:contact => contact}
  end
  
#=====================================================================================
#=====================================================================================  
  def test_action
     @subsections = Company.find(:all)    
      respond_to do |format|
        format.json  { render :json => @subsections }      
      end
  end

#=====================================================================================
  
#=====================================================================================  
  def edit_user_exam
    user_exam = UserExam.find( params[:user_exam_id] )
    render :partial => 'user_exam_view', :locals => { :user_exam => user_exam } 
  end
#=====================================================================================

#=====================================================================================  
  def save_contact_traits
  end
#=====================================================================================
#=====================================================================================  
  private
    def set_user
      @user = current_user
    end
end




