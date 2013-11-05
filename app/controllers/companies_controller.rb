class CompaniesController < ApplicationController
  #before_filter :load_and_authorize_resource
  #before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error

  
#######################################################################################################################
# Objective: To render Company Database page (5.5.7) along with the contents   
# Input:
# Output: render Company Database page (5.5.7) along with the contents
#######################################################################################################################  
  def index
    @companies = Company.non_deleted_companies
    session[:page_title] = session[:tab_title] = "Company Database"
  end
  


#######################################################################################################################
# Objective: To create a new Company 
# Input: params[:company]
# Output: Creates a new Company with data as in params[:company], makes an entry for event log & reloads the Company Database page (5.5.7) contents
#######################################################################################################################  
  def create
    new_cmp = Company.new(params[:company])  if params[:company].present?
    @log_msg = "Company " + new_cmp.id.to_s + " created by User " + current_user.id.to_s    if new_cmp.save 
    
    return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "companies/company_database", :partial_locals => {:companies => Company.non_deleted_companies}, :modal_id => "addcompany", :button_caption => params[:commit] }
  end
  


#######################################################################################################################
# Objective: To render the Company Profile page (5.5.8) along with the contents 
# Input: params[:id]     (id => Company ID)
# Output: Renders the Company Profile page (5.5.8) along with the contents
#######################################################################################################################  
  def show
    @company = Company.find(params[:id])  if params[:id].present?
    @company_notes = Note.notes_of_company @company   if @company.present?
    @active_campaigns = @company.active_campaigns   if @company.present?
    session[:page_title] = "Company Profile"
    session[:tab_title] = "Company Overview"
  end
  


#######################################################################################################################
# Objective: To update a Company 
# Input: params[:company], params[:id]     (id => Company ID)
# Output: Updates a Company with data as in params[:company], makes an entry for event log & reloads the Company Profile Overview page (5.5.8.1) contents
#######################################################################################################################  
  def update
    company = Company.find(params[:id])  if params[:id].present?
    if company.present? && params[:company].present?
      company.attributes = params[:company]   
      updated_attributes = company.changes
      @log_msg = "Company " + company.id.to_s + " details " + updated_attributes.to_s + " updated by user " + current_user.id.to_s    if company.save

      return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "companies/overview", :partial_locals => overiew_params_for_company(company.id), :modal_id => "updatedetails", :button_caption => params[:commit] }
    end
  end
  
  

#######################################################################################################################
# Objective: To create a new Campaign for a Company 
# Input: params[:campaign]
# Output: Creates a new Campaign for a Company with data as in params[:campaign], makes an entry for event log & reloads the Company Profile page (5.5.8) contents
#######################################################################################################################  
  def create_campaign
    new_campaign = Campaign.new(params[:campaign])  if params[:campaign].present?
    @log_msg = "Campaign " + new_campaign.id.to_s + " created by user " + current_user.id.to_s  if new_campaign.save
    
    company = Company.find(params[:campaign][:company_id])
    return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "companies/overview", :partial_locals => overiew_params_for_company(company.id), :modal_id => "newcampaign", :button_caption => params[:commit] }   if params[:from_page] == COMPANY_OVERVIEW
    return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "companies/campaigns", :partial_locals => {:non_deleted_campaigns => company.non_deleted_campaigns, :company => company}, :modal_id => "newcampaign", :button_caption => params[:commit] }   if params[:from_page] == COMPANY_CAMPAIGNS
  end



#######################################################################################################################
# Objective: To create a new Note for a Company 
# Input: params[:note]
# Output: Creates a new Note for a Company with data as in params[:note], makes an entry for event log & reloads the Company Profile page (5.5.8) contents
#######################################################################################################################  
  def create_note
    new_note = Note.new(params[:note])  if params[:note].present?
    @log_msg = "Note " + new_note.id.to_s + " created by user " + current_user.id.to_s   if new_note.save
    
    return render :partial => "overview", :locals => overiew_params_for_company(params[:note][:table_id])
  end
  
  

#######################################################################################################################
# Objective: To create a new Contact for a Company
# Input: params[:user]
# Output: Creates a new Contact for a Company with data as in params[:user], makes an entry for event log & reloads the Company Contact page (5.5.8.3) contents
#######################################################################################################################  
  def create_contact
    company = Company.find(params[:company_id])
    
    if params[:user].present?
      new_user = User.new(params[:user])
      new_user.skip_confirmation!
      
      if new_user.save
        company.update_attributes(:contact => new_user.id)   if params[:primary_contact].present? && params[:primary_contact] == "true"
        UserMailer.welcome_email(new_user.email).deliver  if params[:welcome_email] == "true"
        @log_msg = "Contact " + new_user.id.to_s + " created by user " + current_user.id.to_s
      end   
    end
    
    return render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "companies/contacts", :partial_locals => {:company_contacts => company.contacts, :company => company}, :modal_id => "contactentry", :button_caption => params[:commit] }
  end
  
    

#######################################################################################################################
# Objective: To set Client Contact/TFP Contact for a Company
# Input: params[:id], params[:user_company]
# Output: Sets a Client Contact/TFP Contact for a Company as in params[:user_company], makes an entry for event log & reloads the Company Profile-Contacts page (5.5.8.3) contents
#######################################################################################################################  
  def set_tfp_contact
    user_company = UserCompany.find(params[:user_company_id])   if params[:user_company_id].present?
    @log_msg = "Contact " + params[:user_company][:clientcontact].to_s + " marked/unmarked as TFP Contact by user " + current_user.id.to_s   if user_company.present? && params[:user_company].present? && user_company.update_attributes(params[:user_company])
    
    company = UserCompany.find(params[:user_company_id]).company
    return render :partial => "contacts", :locals => {:company_contacts => company.contacts, :company => company}
  end    




#######################################################################################################################
# Objective: To set Primary Contact for a Company
# Input: params[:company_id], params[:primary_contact]
# Output: Sets a Primary Contact for a Company as in params[:primary_contact], makes an entry for event log & reloads the Company Profile-Contacts page (5.5.8.3) contents
#######################################################################################################################  
  def set_primary_contact
    company = Company.find(params[:company_id])  if params[:company_id].present?
    @log_msg = "Contact " + company.contact.to_s + " marked/unmarked as Primary Contact by user " + current_user.id.to_s   if company.present? && params[:primary_contact].present? && company.update_attributes(:contact => params[:primary_contact])
    
    return render :partial => "contacts", :locals => {:company_contacts => company.contacts, :company => company}   
  end



#######################################################################################################################
# Objective: To update whitelabeling information of a Company 
# Input: params[:company_id], params[:company]
# Output: Updates whitelabeling information of a Company as in params[:company], makes an entry for event log & reloads the Company Profile-Whitelabeling page (5.5.8.4) contents
#######################################################################################################################  
  def update_company_whitelabeling_info
    company = Company.find(params[:company_id])   if params[:company_id].present?
    if company.present? && params[:company].present?
      company.attributes = params[:company]   
      updated_attributes = company.changes
      @log_msg = "Company " + company.id.to_s + " details " + updated_attributes.to_s + " updated by user " + current_user.id.to_s   if company.save
    end
    
    return render :partial => "whitelabeling", :locals => {:company => company}
  end



#######################################################################################################################
# Objective: To create a new Contact Log entry for a Company 
# Input: params[:contact_log]
# Output: Creates a new Contact Log entry for a Company, makes an entry for event log & reloads the Company Profile-Contact Log page (5.5.8.5) contents
#######################################################################################################################  
  def create_contact_log
    new_contact_log = ContactLog.new(params[:contact_log])   if params[:contact_log].present?
    if new_contact_log.save
      @log_msg = "Contact log " + new_contact_log.id.to_s + " created for user " + new_contact_log.to.to_s + " by user " + current_user.id.to_s
      new_contact_log.contact_attachments.first.update_attributes(:private => params[:private].present? ? true : false)   if new_contact_log.contact_attachments.present?
    end
    
    company = Company.find(params[:company_id])
    @from_page = params[:from_page]
    @overview_locals = overiew_params_for_company(company.id)
    @contact_log_locals =  {:company => company, :contact_logs => company.contact_logs}

    respond_to do |format|
      format.js
    end
  end



#######################################################################################################################
# Objective: To create a new cdn_file record or update existing for logo of requested Company 
# Input: params[:company_id], params[:cdn_file]
# Output: Creates a new cdn_file record or update existing for logo of requested Company
#######################################################################################################################  
  def upload_logo
    @company = Company.find(params[:company_id])
    @company.logo.present? && (cdn_file = CdnFile.find(@company.logo)) && cdn_file.present? ? cdn_file.update_attributes(params[:cdn_file]) : (cdn_file = CdnFile.create(params[:cdn_file]))
    @company.update_attributes(:logo => cdn_file.id)
    
    respond_to do |format|
      format.js
    end
  end
    
    
    
#######################################################################################################################
# Objective: To render appropriate profile section for requested profile section of a Company 
# Input: params[:company_id], params[:profile_section]
# Output: Renders appropriate profile section for requested profile section (params[:profile_section]) of a Company
#######################################################################################################################  
  def render_company_profile_section
    if params[:company_id].present? && params[:profile_section].present? 
      company = Company.find(params[:company_id])
      if company.present?
        non_deleted_campaigns = company.non_deleted_campaigns
        company_contacts = company.contacts
        contact_logs = company.contact_logs
      end
      
      case params[:profile_section]
        when COMPANY_OVERVIEW
          return render :partial => "overview", :locals => overiew_params_for_company(company.id)
        when COMPANY_CAMPAIGNS
          return render :partial => "campaigns", :locals => {:non_deleted_campaigns => non_deleted_campaigns, :company => company}
        when COMPANY_CONTACTS
          return render :partial => "contacts", :locals => {:company_contacts => company_contacts, :company => company}
        when COMPANY_WHITELABELING
          return render :partial => "whitelabeling", :locals => {:company => company}
        when COMPANY_CONTACT_LOG      
          return render :partial => "contact_log", :locals => {:company => company, :contact_logs => contact_logs} 
      end
          
    end
  
  end  
  
  
private

#######################################################################################################################
# Objective: To return all parameters required for overview page of a requested Company
# Input: company_id
# Output: Returns all parameters required for overview page of a requested Company
#######################################################################################################################  
  def overiew_params_for_company(company_id)
    company = Company.find(company_id)  if company_id.present?
    if company.present?
      active_campaigns = company.active_campaigns
      company_notes = Note.notes_of_company company
    end
    
    return {:company => company.present? ? company : nil, :company_notes => company_notes.present? ? company_notes : nil , :active_campaigns => active_campaigns.present? ? active_campaigns : nil }
  end   

end
