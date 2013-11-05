class DatabaseManagementsController < ApplicationController
  
  
  #autocomplete :company, :name
  #autocomplete :qualification_type , :name
  #autocomplete :qualification_location, :name
  #autocomplete :qualification_subject, :name
  #autocomplete :qualification_grade, :name
  #autocomplete :itskill, :name
  #autocomplete :language, :name
  
  
  #=====================================================================================================================
  #Objective : to open the Database Management Dashboard Page
  #Input     : databases with basic summary i.e name & their status
  #Output    : databases are shown here with a basic summary of their entries & TFP user will manage them
  #=====================================================================================================================
  def show
    session[:page_title] = session[:tab_title] = "Database Management"
    @internal_traits_count = Trait.where(:status => TRAIT_STATUS_INTERNAL).count
    @public_traits_count =Trait.where(:status => TRAIT_STATUS_PUBLIC).count
    
    @question_categories_count = QuestionCategory.where(:status => QUESTION_CATEGORY_STATUS_ACTIVE).count
    
    @active_companies_count = Company.where(:status => COMPANY_STATUS_ACTIVE).count
    @unconfirmed_companies_count = Company.where(:status => COMPANY_STATUS_UNCONFIRMED).count
    
    @active_qualification_types_count = QualificationType.where(:status => QUALIFICATION_STATUS_ACTIVE).count
    @unconfirmed_qualification_types_count = QualificationType.where(:status => QUALIFICATION_STATUS_UNCONFIRMED).count
  
    @active_qualification_locations_count = QualificationLocation.where(:status => QUALIFICATION_LOCATION_STATUS_ACTIVE).count
    @unconfirmed_qualification_locations_count = QualificationLocation.where(:status => QUALIFICATION_LOCATION_STATUS_UNCONFIRMED).count 
  
    @active_qualification_subjects_count = QualificationSubject.where(:status => QUALIFICATION_SUBJECT_STATUS_ACTIVE).count
    @unconfirmed_qualification_subjects_count = QualificationSubject.where(:status => QUALIFICATION_SUBJECT_STATUS_UNCONFIRMED).count
  
    @active_qualification_grades_count = QualificationGrade.where(:status => QUALIFICATION_GRADE_STATUS_ACTIVE).count
    @unconfirmed_qualification_grades_count = QualificationGrade.where(:status => QUALIFICATION_GRADE_STATUS_UNCONFIRMED).count
    
    @active_itskills_count = Itskill.where(:status => IT_SKILL_STATUS_ACTIVE).count
    @unconfirmed_itskills_count = Itskill.where(:status => IT_SKILL_STATUS_UNCONFIRMED).count
    
    @active_languages_count = Language.where(:status => LANGUAGE_STATUS_ACTIVE).count
    @unconfirmed_languages_count = Language.where(:status => LANGUAGE_STATUS_UNCONFIRMED).count
    
    @log_msg = "Database Management Dashboard Page"      #log message
    
 
      @from_companies = "from_companies" if params[:company_value].present?
      @from_types = "from_types" if params[:type_value].present?
      @from_locations = "from_locations" if params[:location_value].present?
      @from_subjects = "from_subjects" if params[:subject_value].present?
      @from_grades = "from_grades" if params[:grade_value].present?
      @from_itskills = "from_itskills" if params[:itskill_value].present?
      @from_languages = "from_languages" if params[:language_value].present?
   
  end
  
  #=====================================================================================================================
  #Objective : to open the Traits page
  #Input     : @traits(list of traits with all information)
  #Output    : displays traits whose status is internal or public under the title "Traits" 
  #=====================================================================================================================
  def traits
   # @traits = Trait.includes(:question_categories).where('status != ?', 'deleted')
   @traits = Trait.all 
    @log_msg = "Traits page with information of internal or public traits "                                                 #log message
    return render :partial => 'traits',:locals => { :traits_flag => nil }
  end
  
  #=====================================================================================================================
  #Objective : to create new Trait
  #Input     : @trait(inputs to create new Trait)
  #Output    : new Trait is created/added 
  #=====================================================================================================================
  def create_trait
    @trait = Trait.new(params[:trait]) if params[:trait].present?
         if @trait.save
            @log_msg = "New Trait "+ (params[:trait].present? ? @trait.name : "")+ " is created"                   #log message
         else
            @log_msg = "New Trait "+ (params[:trait].present? ? @trait.name : "")+ " is not created"               #log message
         end  
      
 #    @traits = Trait.includes(:question_categories).where('status != ?', 'deleted')
   	 @traits = Trait.all
     partial_locals = {:traits => @traits, :traits_flag => nil }
     render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "traits", :partial_locals => partial_locals, :modal_id => "newtrait", :button_caption => params[:commit] }
  end
   
  #=====================================================================================================================
  #Objective : to open the light box to edit trait
  #Input     : @trait(inputs of created Trait)     
  #Output    : Control goes to edit Edit Trait Page 
  #=====================================================================================================================
  def edit_trait_type
     @trait = Trait.find(params[:trait_id])
     return render :partial => "edit_trait", :locals => {:trait => @trait}
  end
  
  #=====================================================================================================================
  #Objective : to update the trait information
  #Input     : @trait(inputs of created Trait)      
  #Output    : Changed information of trait is saved in database 
  #=====================================================================================================================
  def update_trait
    @trait = Trait.find(params[:id])
   
        if @trait.update_attributes(params[:trait])
           @log_msg = "Edit Trait "+ (params[:trait].present? ? @trait.name : "")+ " is edited"                   #log message  
        end
    
  # @traits = Trait.includes(:question_categories).where('status != ?', 'deleted')
   @traits = Trait.all
   partial_locals = {:traits => @traits, :traits_flag => nil }
   render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "traits", :partial_locals => partial_locals, :modal_id => "edittrait", :button_caption => params[:commit] } 
  end
  
  #=====================================================================================================================
  #Objective : to delete the trait 
  #Input     : @trait(inputs of selected Trait)      
  #Output    : Status of trait is changed to deleted 
  #=====================================================================================================================
  def remove_trait
    @trait = Trait.find(params[:traitID])
    @trait_user = UserTrait.where(:trait_id => params[:traitID])

        if !@trait_user.present?
            @trait.update_attributes(:status => "deleted")
            @log_msg = "Delete Trait "+ (params[:traitID].present? ? @trait.name : "")+ " is deleted"                   #log message  
            flag = false
        else
            @log_msg = "Delete Trait "+ (params[:traitID].present? ? @trait.name : "")+ " is not deleted"                #log message  
            flag = true
        end
 
    #@traits = @traits = Trait.includes(:question_categories).where('status != ?', 'deleted')
    @traits = Trait.all
    render :partial => 'traits', :locals => {:traits => @traits , :traits_flag => flag }
  end
  
  
  #=====================================================================================================================
  #Objective : to open the Question Types page
  #Input     : @question_categories(list of question types with all information),
  #            @traits_lists(list of traits whose status is internal or public)
  #Output    : displays question types whose status is active under the title "Traits" 
  #=====================================================================================================================
  def question_categories
    @question_categories = QuestionCategory.all
    @traits_lists = Trait.where(:status => ["internal", "public"])
    @log_msg = "Question Types page with information of active question types"                                    #log message
    return render :partial => 'question_categories', :locals => {:question_categories => @question_categories, :traits_lists => @traits_lists ,:question_categories_flag => nil }
  end
  
  #=====================================================================================================================
  #Objective : to create new Question Type
  #Input     : @question_category(inputs to create new Question type)
  #Output    : new question type is created/added 
  #=====================================================================================================================
  def create_question_category
    @question_category = QuestionCategory.new(params[:question_category]) if params[:question_category].present?
    
         if @question_category.save
            @log_msg = "New Question Type "+ (params[:question_category].present? ? @question_category.name : "")+ " is created"                   #log message
         else
            @log_msg = "New Question Type "+ (params[:question_category].present? ? @question_category.name : "")+ " is not created"               #log message
         end  
     
    @traits_lists = Trait.where(:status => ["internal", "public"])
    @question_categories = QuestionCategory.all
    partial_locals = {:question_categories => @question_categories, :traits_lists => @traits_lists , :question_categories_flag => nil}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "question_categories", :partial_locals => partial_locals, :modal_id => "newquestiontype", :button_caption => params[:commit] }
  end
  
  #=====================================================================================================================
  #Objective : to open the light box to edit question type
  #Input     : @question_category(inputs of created question type),  
  #            @traits_lists(list of traits whose status is internal or public)
  #Output    : Control goes to edit Edit question type Page 
  #=====================================================================================================================
  def edit_question_category
 
    @question_category = QuestionCategory.find(params[:question_category_id])
    @traits_lists = Trait.where(:status => ["internal", "public"])
    return render :partial => "edit_category", :locals => {:question_category => @question_category, :traits_lists => @traits_lists}
  end
  
  #=====================================================================================================================
  #Objective : to update the question type information
  #Input     : @question_category(inputs of created question type),
  #            @traits_lists(list of traits whose status is internal or public)     
  #Output    : Changed information of question type is saved in database 
  #=====================================================================================================================
  def update_question_category
 
    @question_category = QuestionCategory.find(params[:id])
     
        if @question_category.update_attributes(params[:question_category])
           @log_msg = "Edit Question Type "+ (params[:question_category].present? ? @question_category.name : "")+ " is edited"                   #log message  
        end
        
    @question_categories = QuestionCategory.all
    @traits_lists = Trait.where(:status => ["internal", "public"])
    partial_locals = {:question_category => @question_category, :question_categories => @question_categories, :question_categories_flag => nil}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "question_categories", :partial_locals => partial_locals, :modal_id => "editquestiontype", :button_caption => "" }
  end
  
  #=====================================================================================================================
  #Objective : to delete the question type 
  #Input     : @question_category(inputs of selected question type)      
  #Output    : Status of question type is changed to deleted 
  #=====================================================================================================================
  def remove_question_category
    @question_category = QuestionCategory.find(params[:categoryID])
    @question_category_type = Question.where(:question_category_id => params[:categoryID])
   
        if !@question_category_type.present?
     
            @question_category.update_attributes(:status => "deleted")
            @log_msg = "Delete question type  "+ (params[:categoryID].present? ? @question_category.name : "")+ " is deleted"                   #log message  
            flag = false
        else
            flag = true
            @log_msg = "Delete question type  "+ (params[:categoryID].present? ? @question_category.name : "")+ " is not deleted"                   #log message  
            
        end 

    @question_categories = QuestionCategory.all
    @traits_lists = Trait.where(:status => ["internal", "public"])
    render :partial => 'question_categories', :locals => {:question_categories => @question_categories, :traits_lists => @traits_lists, :question_categories_flag => flag}
  
  end  
  
  #=====================================================================================================================
  #Objective : to open the Companies page
  #Input     : @companies(list of Companies with all information),
  #            @unconfirmed_companies(list of Companies whose status is unconfirmed)
  #Output    : displays companies whose status is unconfirmed under the title "Unconfirmed Companies" & 
  #            displays all(non-deleted) companies under the title "Companies"
  #=====================================================================================================================
  def companies
    @companies = Company.all
    @unconfirmed_companies = Company.where(:status => COMPANY_STATUS_UNCONFIRMED)
    
    @log_msg = "Companies page with information of all non-deleted companies & unconfirmed companies"      #log message
    return render :partial => 'companies', :locals => {:companies => @companies, :unconfirmed_companies => @unconfirmed_companies, :companies_flag => nil}
  end
  
  #=====================================================================================================================
  #Objective : to change company status to active
  #Input     : @company(id of company whose status is going to change)
  #Output    : company status is changed from 'unconfirmed' to 'active' & that company record is removed from
  #            "Unconfirmed Companies" list
  #=====================================================================================================================
  def change_company_status_to_active
    @company= Company.find(params[:id])
      if @company
         @company.update_attributes(:status => COMPANY_STATUS_ACTIVE)
         @log_msg = "Company "+ (params[:id].present? ? @company.name : "") +" status is updated to 'active' from 'unconfirmed'"     #log message
      end
    
    @companies = Company.all
    @unconfirmed_companies = Company.where(:status => COMPANY_STATUS_UNCONFIRMED)
    render :partial => 'companies', :locals => {:companies => @companies , :unconfirmed_companies => @unconfirmed_companies ,:companies_flag => nil }
  end
  
  #=====================================================================================================================
  #Objective : to change unconfirmed company status to deleted & users company name
  #Input     : @active_company(id of active company),
  #            @unconfirmed_company(id of unconfirmed company)
  #Output    : company status is changed from 'unconfirmed' to 'deleted' & company name of user is replace with 
  #            company whose status is active
  #=====================================================================================================================
  def change_company_status_to_deleted
    @active_company = Company.find_by_name(params[:company_selected]) 
    if Company.find_by_name(params[:company_selected])
   
          @unconfirmed_company = Company.find(params[:company_selected_id])
      
            if @unconfirmed_company
               @unconfirmed_company.update_attributes(:status => "deleted")
               @log_msg = "Company "+ (params[:company_selected_id].present? ? @unconfirmed_company.name : "") +" status is updated to 'deleted' from 'unconfirmed'"    #log message         
            end
            
          @unconfirmed_company_id = @unconfirmed_company.id
          @user=UserCompany.where(:company_id => @unconfirmed_company_id).first
      
            if @user
               @user.update_attributes(:company_id => @active_company.id)
               @log_msg = "Company "+ (params[:company_selected_id].present? ? @unconfirmed_company.name : "")+ " of user is replace with company "+ (params[:company_selected].present? ? @active_company.name : "") +" whose status is active"      #log message         
            end
           
           flag = false
    else
           flag = true
          @log_msg = "Company is not present in database"                                                                                                              #log message         
           
    end
  
    @companies = Company.all
    @unconfirmed_companies = Company.where(:status => COMPANY_STATUS_UNCONFIRMED)
    render :partial => 'companies', :locals => {:companies => @companies , :unconfirmed_companies => @unconfirmed_companies, :companies_flag => flag }
  end
  
  #=====================================================================================================================
  #Objective : to open the Qualification Types page
  #Input     : @qualification_types(list of Qualification Types with all information),
  #            @unconfirmed_qualification_types(list of Qualification Types whose status is unconfirmed)
  #Output    : displays qualification types whose status is 'unconfirmed' under the title "Unconfirmed Qualification Types" 
  #            & displays all(non-deleted) qualification types under the title "Qualification Types"
  #=====================================================================================================================
  def qualification_types
    
    @qualification_types = QualificationType.all
    @unconfirmed_qualification_types = QualificationType.where(:status => QUALIFICATION_STATUS_UNCONFIRMED)
 
    @log_msg = "Qualification Types page with information of all non-deleted qualification types & unconfirmed qualification types"      #log message
    return render :partial => 'qualification_types', :locals => {:qualification_types => @qualification_types, :unconfirmed_qualification_types => @unconfirmed_qualification_types, :qualifications_flag => nil }
  end
  
  #=====================================================================================================================
  #Objective : to change qualification type status to active
  #Input     : @qualification_type(id of qualification type whose status is going to change)
  #Output    : qualification type status is changed from 'unconfirmed' to 'active' & that qualification type record is 
  #            removed from "Unconfirmed Qualification Types" list
  #=====================================================================================================================
  def change_qualification_type_status_to_active
    @qualification_type = QualificationType.find(params[:id])
    
      if @qualification_type
         @qualification_type.update_attributes(:status => QUALIFICATION_STATUS_ACTIVE)
         @log_msg = "Qualification Type "+ (params[:id].present? ? @qualification_type.name : "") +" status is updated to 'active' from 'unconfirmed'"     #log message        
      end
    @qualification_types = QualificationType.all
    @unconfirmed_qualification_types = QualificationType.where(:status => QUALIFICATION_STATUS_UNCONFIRMED)
    render :partial => 'qualification_types', :locals => {:qualification_types => @qualification_types , :unconfirmed_qualification_types => @unconfirmed_qualification_types, :qualifications_flag => nil }
  end
  
  #=====================================================================================================================
  #Objective : to change unconfirmed qualification type status to deleted & users qualification type name
  #Input     : @active_qualification_type(id of active qualification type),
  #            @unconfirmed_qualification_type(id of unconfirmed qualification type)
  #Output    : qualification type status is changed from 'unconfirmed' to 'deleted' & qualification type of user is 
  #            replace with qualification type whose status is active
  #=====================================================================================================================
  def change_qualification_type_status_to_deleted
   @active_qualification_type = QualificationType.find_by_name(params[:qualification_type_selected]) 
   if QualificationType.find_by_name(params[:qualification_type_selected]) 
         @unconfirmed_qualification_type = QualificationType.find(params[:qualification_type_selected_id])
          
            if @unconfirmed_qualification_type
               @unconfirmed_qualification_type.update_attributes(:status => "deleted")
               @log_msg = "Qualification Type"+ (params[:qualification_type_selected_id].present? ? @unconfirmed_qualification_type.name : "") +" status is updated to 'deleted' from 'unconfirmed'"    #log message         
            end
            
          @unconfirmed_qualification_type_id = @unconfirmed_qualification_type.id
          @user=UserQualification.where(:qualification_type_id => @unconfirmed_qualification_type_id).first
      
            if @user
               @user.update_attributes(:qualification_type_id => @active_qualification_type.id)
               @log_msg = "Qualification Type "+ (params[:qualification_type_selected_id].present? ? @unconfirmed_qualification_type.name : "")+ " of user is replace with qualification type "+ (params[:qualification_type_selected].present? ? @active_qualification_type.name : "") +" whose status is active"      #log message         
            end
            
           flag = false
    else
           flag = true
          @log_msg = "Qualification Type is not present in database"                                                                                                              #log message         
      
    end
     
    @qualification_types = QualificationType.all
    @unconfirmed_qualification_types = QualificationType.where(:status => QUALIFICATION_STATUS_UNCONFIRMED)
    render :partial => 'qualification_types', :locals => {:qualification_types => @qualification_types , :unconfirmed_qualification_types => @unconfirmed_qualification_types, :qualifications_flag => flag }
  end
  
  #=====================================================================================================================
  #Objective : to create new qualifictaion type
  #Input     : @qualificationtype(inputs to create new qualification type)
  #Output    : new qualification type is created/added 
  #=====================================================================================================================
  def create_qualification_type
    @qualificationtype = QualificationType.new(params[:qualification_type]) if params[:qualification_type].present?
   
    if @qualificationtype.save
        @log_msg = "New Qualification Type "+ (params[:qualification_type].present? ? @qualificationtype.name : "")+ " is created"                   #log message
    else
        @log_msg = "New Qualification Type "+ (params[:qualification_type].present? ? @qualificationtype.name : "")+ " is not created"               #log message
    end  
    
    @qualification_types = QualificationType.all
    @unconfirmed_qualification_types = QualificationType.where(:status => QUALIFICATION_STATUS_UNCONFIRMED)
    
    partial_locals = {:qualification_types => @qualification_types , :unconfirmed_qualification_types => @unconfirmed_qualification_types, :qualifications_flag => nil }
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "qualification_types", :partial_locals => partial_locals, :modal_id => "qualificationtype", :button_caption => params[:commit] }
  end
  
  #=====================================================================================================================
  #Objective : to open the Qualification Locations page
  #Input     : @qualification_locations(list of Qualification Locations with all information),
  #            @unconfirmed_qualification_locations(list of Qualification Locations whose status is unconfirmed)
  #Output    : displays qualification locations whose status is 'unconfirmed' under the title "Unconfirmed Qualification Locations" 
  #            & displays all(non-deleted) qualification locations under the title "Qualification Locations"
  #=====================================================================================================================
  def qualification_locations

    @qualification_locations = QualificationLocation.all
    @unconfirmed_qualification_locations = QualificationLocation.where(:status => QUALIFICATION_LOCATION_STATUS_UNCONFIRMED)
  
    @log_msg = "Qualification Locations page with information of all non-deleted qualification locations & unconfirmed qualification locations"      #log message
    return render :partial => 'qualification_locations' , :locals => {:qualification_locations => @qualification_locations, :unconfirmed_qualification_locations => @unconfirmed_qualification_locations, :locations_flag => nil }
  end
  
  #=====================================================================================================================
  #Objective : to change qualification location status to active
  #Input     : @qualification_location(id of qualification location whose status is going to change)
  #Output    : qualification location status is changed from 'unconfirmed' to 'active' & that qualification location  
  #            record is removed from "Unconfirmed Qualification Locations" list
  #=====================================================================================================================
  def change_location_status_to_active
    @qualification_location = QualificationLocation.find(params[:id])
      if @qualification_location
         @qualification_location.update_attributes(:status => QUALIFICATION_LOCATION_STATUS_ACTIVE)
         @log_msg = "Qualification Location "+ (params[:id].present? ? @qualification_location.name : "") +" status is updated to 'active' from 'unconfirmed'"     #log message         
      end
      
    @qualification_locations = QualificationLocation.all
    @unconfirmed_qualification_locations = QualificationLocation.where(:status => QUALIFICATION_LOCATION_STATUS_UNCONFIRMED)
    render :partial => 'qualification_locations', :locals => {:qualification_locations => @qualification_locations , :unconfirmed_qualification_locations => @unconfirmed_qualification_locations, :locations_flag => nil }

  end
  
  #=====================================================================================================================
  #Objective : to change unconfirmed qualification location status to deleted & users qualification location name
  #Input     : @active_qualification_location(id of active qualification location),
  #            @unconfirmed_qualification_location(id of unconfirmed qualification location)
  #Output    : qualification location status is changed from 'unconfirmed' to 'deleted' & qualification location of user  
  #            is replace with qualification location whose status is active
  #=====================================================================================================================
  def change_location_status_to_deleted
    @active_qualification_location = QualificationLocation.find_by_name(params[:qualification_location_selected]) 
    if QualificationLocation.find_by_name(params[:qualification_location_selected]) 
        @unconfirmed_qualification_location = QualificationLocation.find(params[:qualification_location_selected_id])
        
          if @unconfirmed_qualification_location
             @unconfirmed_qualification_location.update_attributes(:status => "deleted")
             @log_msg = "Qualification Location "+ (params[:qualification_location_selected_id].present? ? @unconfirmed_qualification_location.name : "") +" status is updated to 'deleted' from 'unconfirmed'"    #log message         
          end
          
        @unconfirmed_qualification_location_id = @unconfirmed_qualification_location.id
        @user=UserQualification.where(:qualification_location_id => @unconfirmed_qualification_location_id).first
    
          if @user
             @user.update_attributes(:qualification_location_id => @active_qualification_location.id)
             @log_msg = "qualification Location "+ (params[:qualification_location_selected_id].present? ? @unconfirmed_qualification_location.name : "")+ " of user is replace with qualification location "+ (params[:qualification_location_selected].present? ? @active_qualification_location.name : "") +" whose status is active"      #log message
          end
           flag = false
    else
           flag = true
          @log_msg = "Qualification Location is not present in database"                                                                                                              #log message         
      
    end
       
    @qualification_locations = QualificationLocation.all
    @unconfirmed_qualification_locations = QualificationLocation.where(:status => QUALIFICATION_LOCATION_STATUS_UNCONFIRMED)
    render :partial => 'qualification_locations', :locals => {:qualification_locations => @qualification_locations , :unconfirmed_qualification_locations => @unconfirmed_qualification_locations, :locations_flag => flag }
    
  end
  
  #=====================================================================================================================
  #Objective : to create new qualifictaion location
  #Input     : @qualificationlocation(inputs to create new qualification location)
  #Output    : new qualification location is created/added 
  #=====================================================================================================================
  def create_qualification_location
    @qualificationlocation = QualificationLocation.new(params[:qualification_location]) if params[:qualification_location].present?
   
    if @qualificationlocation.save
        @log_msg = "New Qualification Location "+ (params[:qualification_location].present? ? @qualificationlocation.name : "")+ " is created"                   #log message
    else
        @log_msg = "New Qualification Location "+ (params[:qualification_location].present? ? @qualificationlocation.name : "")+ " is not created"               #log message
    end  
    
    @qualification_locations = QualificationLocation.all
    @unconfirmed_qualification_locations = QualificationLocation.where(:status => QUALIFICATION_LOCATION_STATUS_UNCONFIRMED)
    partial_locals = {:qualification_locations => @qualification_locations , :unconfirmed_qualification_locations => @unconfirmed_qualification_locations, :locations_flag => nil }
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "qualification_locations", :partial_locals => partial_locals, :modal_id => "qualificationlocation", :button_caption => params[:commit] }
 
  end
  
  #=====================================================================================================================
  #Objective : to open the Qualification Subjects page
  #Input     : @qualification_subjects(list of Qualification Subjects with all information),
  #            @unconfirmed_qualification_subjects(list of Qualification Subjects whose status is unconfirmed)
  #Output    : displays qualification subjects whose status is 'unconfirmed' under the title "Unconfirmed Qualification Subjects" 
  #            & displays all(non-deleted) qualification subjects under the title "Qualification Subjects"
  #=====================================================================================================================
  def qualification_subjects
    
    @qualification_subjects = QualificationSubject.all
    @unconfirmed_qualification_subjects = QualificationSubject.where(:status => QUALIFICATION_SUBJECT_STATUS_UNCONFIRMED)
 
    @log_msg = "Qualification Subjects page with information of all non-deleted qualification subjects & unconfirmed qualification subjects"      #log message
    return render :partial => 'qualification_subjects', :locals => {:qualification_subjects => @qualification_subjects, :unconfirmed_qualification_subjects => @unconfirmed_qualification_subjects, :subjects_flag => nil}
  end
  
  #=====================================================================================================================
  #Objective : to change qualification subject status to active
  #Input     : @qualification_subject(id of qualification subject whose status is going to change)
  #Output    : qualification subject status is changed from 'unconfirmed' to 'active' & that qualification subject 
  #            record is removed from "Unconfirmed Qualification Subjects" list
  #=====================================================================================================================
  def change_subject_status_to_active
    @qualification_subject = QualificationSubject.find(params[:id])
      if @qualification_subject
         @qualification_subject.update_attributes(:status => QUALIFICATION_SUBJECT_STATUS_ACTIVE)
         @log_msg = "Qualification Subject "+ (params[:id].present? ? @qualification_subject.name : "") +"status is updated to 'active' from 'unconfirmed'"     #log message
      end
    
    @qualification_subjects = QualificationSubject.all
    @unconfirmed_qualification_subjects = QualificationSubject.where(:status => QUALIFICATION_SUBJECT_STATUS_UNCONFIRMED)
    render :partial => 'qualification_subjects', :locals => {:qualification_subjects => @qualification_subjects , :unconfirmed_qualification_subjects => @unconfirmed_qualification_subjects, :subjects_flag => nil }
     
  end
  
  #=====================================================================================================================
  #Objective : to change unconfirmed qualification subject status to deleted & users qualification subject name
  #Input     : @active_qualification_subject(id of active qualification subject),
  #            @unconfirmed_qualification_subject(id of unconfirmed qualification subject)
  #Output    : qualification subject status is changed from 'unconfirmed' to 'deleted' & qualification subject of user  
  #            is replace with qualification subject whose status is active
  #=====================================================================================================================
  def change_subject_status_to_deleted
    @active_qualification_subject = QualificationSubject.find_by_name(params[:qualification_subject_selected]) 
    if QualificationSubject.find_by_name(params[:qualification_subject_selected]) 
        @unconfirmed_qualification_subject = QualificationSubject.find(params[:qualification_subject_selected_id])
        
            if @unconfirmed_qualification_subject
               @unconfirmed_qualification_subject.update_attributes(:status => "deleted")
               @log_msg = "Qualification Subject "+ (params[:qualification_subject_selected_id].present? ? @unconfirmed_qualification_subject.name : "") +" status is updated to 'deleted' from 'unconfirmed'"        #log message        
            end
            
          @unconfirmed_qualification_subject_id = @unconfirmed_qualification_subject.id
          @user=UserQualification.where(:qualification_subject_id => @unconfirmed_qualification_subject_id).first
      
            if @user
               @user.update_attributes(:qualification_subject_id => @active_qualification_subject.id)
               @log_msg = "Qualification Subject "+ (params[:qualification_subject_selected_id].present? ? @unconfirmed_qualification_subject.name : "")+ " of user is replace with qualification subject "+ (params[:qualification_subject_selected].present? ? @active_qualification_subject.name : "") +" whose status is active"      #log message
            end
          
           flag = false
      else
           flag = true
           @log_msg = "Qualification Subject is not present in database"                                                                                                              #log message         
        
    end
    
    @qualification_subjects = QualificationSubject.all
    @unconfirmed_qualification_subjects = QualificationSubject.where(:status => QUALIFICATION_SUBJECT_STATUS_UNCONFIRMED)
    render :partial => 'qualification_subjects', :locals => {:qualification_subjects => @qualification_subjects , :unconfirmed_qualification_subjects => @unconfirmed_qualification_subjects, :subjects_flag => flag }
     
  end
  
  #=====================================================================================================================
  #Objective : to create new qualifictaion subject
  #Input     : @qualificationsubject(inputs to create new qualification subject)
  #Output    : new qualification subject is created/added 
  #=====================================================================================================================
  def create_qualification_subject
    @qualificationsubject = QualificationSubject.new(params[:qualification_subject]) if params[:qualification_subject].present?
    
    if @qualificationsubject.save
        @log_msg = "New Qualification Subject "+ (params[:qualification_subject].present? ? @qualificationsubject.name : "")+ " is created"                   #log message
    else
        @log_msg = "New Qualification Subject "+ (params[:qualification_subject].present? ? @qualificationsubject.name : "")+ " is not created"               #log message
    end  
    
    @qualification_subjects = QualificationSubject.all
    @unconfirmed_qualification_subjects = QualificationSubject.where(:status => QUALIFICATION_SUBJECT_STATUS_UNCONFIRMED)
    partial_locals = {:qualification_subjects => @qualification_subjects , :unconfirmed_qualification_subjects => @unconfirmed_qualification_subjects, :subjects_flag => nil }
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "qualification_subjects", :partial_locals => partial_locals, :modal_id => "qualificationsubject", :button_caption => params[:commit] }
 
  end
  
  #=====================================================================================================================
  #Objective : to open the Qualification Grades page
  #Input     : @qualification_grades(list of Qualification Grades with all information),
  #            @unconfirmed_qualification_grades(list of Qualification Grades whose status is unconfirmed)
  #Output    : displays qualification grades whose status is 'unconfirmed' under the title "Unconfirmed Qualification Grades" 
  #            & displays all(non-deleted) qualification grades under the title "Qualification Grades"
  #=====================================================================================================================
  def qualification_grades
    
    @qualification_grades = QualificationGrade.all
    @unconfirmed_qualification_grades = QualificationGrade.where(:status => QUALIFICATION_GRADE_STATUS_UNCONFIRMED)
  
    @log_msg = "Qualification Grades page with information of all non-deleted qualification grades & unconfirmed qualification grades"      #log message
    return render :partial => 'qualification_grades', :locals => {:qualification_grades => @qualification_grades, :unconfirmed_qualification_grades => @unconfirmed_qualification_grades, :grades_flag => nil}
  end
  
  #=====================================================================================================================
  #Objective : to change qualification grade status to active
  #Input     : @qualification_grade(id of qualification grade whose status is going to change)
  #Output    : qualification grade status is changed from 'unconfirmed' to 'active' & that qualification grade record is 
  #            removed from "Unconfirmed Qualification Grades" list
  #=====================================================================================================================
  def change_grade_status_to_active
    @qualification_grade = QualificationGrade.find(params[:id])
      if @qualification_grade
         @qualification_grade.update_attributes(:status => QUALIFICATION_GRADE_STATUS_ACTIVE)
         @log_msg = "Qualification Grade "+ (params[:id].present? ? @qualification_grade.name : "") +"status is updated to 'active' from 'unconfirmed'"     #log message
     end
    
    @qualification_grades = QualificationGrade.all
    @unconfirmed_qualification_grades = QualificationGrade.where(:status => QUALIFICATION_GRADE_STATUS_UNCONFIRMED)
    render :partial => 'qualification_grades', :locals => {:qualification_grades => @qualification_grades , :unconfirmed_qualification_grades => @unconfirmed_qualification_grades, :grades_flag => nil }
   
  end
  
  #=====================================================================================================================
  #Objective : to change unconfirmed qualification grade status to deleted & users qualification grade name
  #Input     : @active_qualification_grade(id of active qualification grade),
  #            @unconfirmed_qualification_grade(id of unconfirmed qualification grade)
  #Output    : qualification grade status is changed from 'unconfirmed' to 'deleted' & qualification grade of user is 
  #            replace with qualification grade whose status is active
  #=====================================================================================================================
  def change_grade_status_to_deleted
    @active_qualification_grade = QualificationGrade.find_by_name(params[:qualification_grade_selected]) 
    if QualificationGrade.find_by_name(params[:qualification_grade_selected]) 
          @unconfirmed_qualification_grade = QualificationGrade.find(params[:qualification_grade_selected_id])
          
              if @unconfirmed_qualification_grade
                 @unconfirmed_qualification_grade.update_attributes(:status => "deleted")
                 @log_msg = "Qualification Grade "+ (params[:qualification_grade_selected_id].present? ? @unconfirmed_qualification_grade.name : "") +" status is updated to 'deleted' from 'unconfirmed'"        #log message
              end
              
            @unconfirmed_qualification_grade_id = @unconfirmed_qualification_grade.id
            @user=UserQualification.where(:qualification_grade_id => @unconfirmed_qualification_grade_id).first
        
              if @user
                 @user.update_attributes(:qualification_grade_id => @active_qualification_grade.id)
                 @log_msg = "qualification Grade "+ (params[:qualification_grade_selected_id].present? ? @unconfirmed_qualification_grade.name : "")+ " of user is replace with qualification grade "+ (params[:qualification_grade_selected].present? ? @active_qualification_grade.name : "") +" whose status is active"      #log message
              end
              
              flag = false
      else
              flag = true
             @log_msg = "Qualification Grade is not present in database"                                                                                                              #log message         
          
    end
    
    @qualification_grades = QualificationGrade.all
    @unconfirmed_qualification_grades = QualificationGrade.where(:status => QUALIFICATION_GRADE_STATUS_UNCONFIRMED)
    render :partial => 'qualification_grades', :locals => {:qualification_grades => @qualification_grades , :unconfirmed_qualification_grades => @unconfirmed_qualification_grades, :grades_flag => flag }
     
  end
  
  #=====================================================================================================================
  #Objective : to create new qualifictaion grade
  #Input     : @qualificationgrade(inputs to create new qualification grade)
  #Output    : new qualification grade is created/added 
  #=====================================================================================================================
  def create_qualification_grade
    @qualificationgrade = QualificationGrade.new(params[:qualification_grade]) if params[:qualification_grade].present?
   
    if @qualificationgrade.save
        @log_msg = "New Qualification Grade "+ (params[:qualification_grade].present? ? @qualificationgrade.name : "")+ " is created"                   #log message
    else
        @log_msg = "New Qualification Grade "+ (params[:qualification_grade].present? ? @qualificationgrade.name : "")+ " is not created"               #log message
    end  
    
    @qualification_grades = QualificationGrade.all
    @unconfirmed_qualification_grades = QualificationGrade.where(:status => QUALIFICATION_GRADE_STATUS_UNCONFIRMED)
    partial_locals = {:qualification_grades => @qualification_grades , :unconfirmed_qualification_grades => @unconfirmed_qualification_grades, :grades_flag => nil }
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "qualification_grades", :partial_locals => partial_locals, :modal_id => "qualificationgrade", :button_caption => params[:commit] }
   
  end
  
  #===================================================================================================================== 
  #Objective : to open the Itskills page
  #Input     : @itskills(list of Itskills with all information),
  #            @unconfirmed_itskills(list of Itskills whose status is unconfirmed)
  #Output    : displays itskills whose status is unconfirmed under the title "Unconfirmed It Skills" & 
  #            displays all(non-deleted) itskills under the title "It Skills"
  #=====================================================================================================================
  def itskills
        
    @itskills = Itskill.all
    @unconfirmed_itskills = Itskill.where(:status => IT_SKILL_STATUS_UNCONFIRMED)
    
    @log_msg = "IT Skills page with information of all non-deleted IT skills & unconfirmed IT skills"      #log message
    return render :partial => 'itskills', :locals => {:itskills => @itskills, :unconfirmed_itskills => @unconfirmed_itskills, :itskills_flag => nil }
  end
  
  #=====================================================================================================================
  #Objective : to change itskill status to active
  #Input     : @itskill(id of itskill whose status is going to change)
  #Output    : itskill status is changed from 'unconfirmed' to 'active' & that itskill record is removed from
  #            "Unconfirmed It Skills" list
  #=====================================================================================================================
  def change_itskill_status_to_active
    @itskill = Itskill.find(params[:id])
      if @itskill
         @itskill.update_attributes(:status => IT_SKILL_STATUS_ACTIVE)
         @log_msg = "IT skill "+ (params[:id].present? ? @itskill.name : "") +" status is updated to 'active' from 'unconfirmed'"     #log message
         
      end
    @itskills = Itskill.all
    @unconfirmed_itskills = Itskill.where(:status => IT_SKILL_STATUS_UNCONFIRMED)
    render :partial => 'itskills', :locals => {:itskills => @itskills , :unconfirmed_itskills => @unconfirmed_itskills, :itskills_flag => nil }
          
  end
  
  #=====================================================================================================================
  #Objective : to change unconfirmed itskill status to deleted & users itskill
  #Input     : @active_itskill(id of active itskill),
  #            @unconfirmed_itskill(id of unconfirmed itskill)
  #Output    : itskill status is changed from 'unconfirmed' to 'deleted' & itskill name of user is replace with 
  #            itskill whose status is active
  #=====================================================================================================================
  def change_itskill_status_to_deleted
   @active_itskill = Itskill.find_by_name(params[:itskill_selected])
  if Itskill.find_by_name(params[:itskill_selected])
       @unconfirmed_itskill = Itskill.find(params[:itskill_selected_id])
        
          if @unconfirmed_itskill
             @unconfirmed_itskill.update_attributes(:status => "deleted")
             @log_msg = "It skill "+ (params[:itskill_selected_id].present? ? @unconfirmed_itskill.name : "") +" status is updated to 'deleted' from 'unconfirmed'"        #log message         
          end
          
        @unconfirmed_itskill_id = @unconfirmed_itskill.id
        @user=UserItskill.where(:itskill_id => @unconfirmed_itskill_id).first
    
          if @user
             @user.update_attributes(:itskill_id => @active_itskill.id)
             @log_msg = "It skill "+ (params[:itskill_selected_id].present? ? @unconfirmed_itskill.name : "")+ " of user is replace with IT skill "+ (params[:itskill_selected].present? ? @active_itskill.name : "") +" whose status is active"      #log message         
          end
          
              flag = false
      else
              flag = true
             @log_msg = "IT Skill is not present in database"                                                                                                              #log message         
          
    end

   @itskills = Itskill.all
   @unconfirmed_itskills = Itskill.where(:status => IT_SKILL_STATUS_UNCONFIRMED)
   render :partial => 'itskills', :locals => {:itskills => @itskills , :unconfirmed_itskills => @unconfirmed_itskills, :itskills_flag => flag }
     
  end
  
  #=====================================================================================================================
  #Objective : to create new itskill
  #Input     : @itskill(inputs to create new itskill)
  #Output    : new itskill is created/added 
  #=====================================================================================================================
  def create_itskill
    @itskill = Itskill.new(params[:itskill]) if params[:itskill].present?
   
    if @itskill.save
        #redirect_to(:action => 'itskills', :controller => "database_managements")
        @log_msg = "New IT Skill "+ (params[:itskill].present? ? @itskill.name : "")+ " is created"                      #log message
    else
        #redirect_to(:action => 'itskills', :controller => "database_managements")
        @log_msg = "New IT Skill "+ (params[:itskill].present? ? @itskill.name : "")+ " is not created"                  #log message
    end
   @itskills = Itskill.all
   @unconfirmed_itskills = Itskill.where(:status => IT_SKILL_STATUS_UNCONFIRMED)
   partial_locals = {:itskills => @itskills , :unconfirmed_itskills => @unconfirmed_itskills, :itskills_flag => nil }
   render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "itskills", :partial_locals => partial_locals, :modal_id => "qualification_itskill", :button_caption => params[:commit] }
   
  end
  
  #=====================================================================================================================
  #Objective : to open the Languages page
  #Input     : @languages(list of Languages with all information),
  #            @unconfirmed_languages(list of Languages whose status is unconfirmed)
  #Output    : displays languages whose status is unconfirmed under the title "Unconfirmed Languages" & 
  #            displays all(non-deleted) languages under the title "Languages"
  #=====================================================================================================================
  def languages
    
    @languages = Language.all
    @unconfirmed_languages = Language.where(:status => LANGUAGE_STATUS_UNCONFIRMED)
    
    @log_msg = "Languages page with information of all non-deleted languages & unconfirmed languages"      #log message
    return render :partial => 'languages' , :locals => {:languages => @languages , :unconfirmed_languages => @unconfirmed_languages, :languages_flag => nil}
  end
  
  #=====================================================================================================================
  #Objective : to change language status to active
  #Input     : @language(id of language whose status is going to change)
  #Output    : language status is changed from 'unconfirmed' to 'active' & that language record is removed from
  #            "Unconfirmed Languages" list
  #=====================================================================================================================
  def change_language_status_to_active
    @language = Language.find(params[:id])
      if @language
         @language.update_attributes(:status => LANGUAGE_STATUS_ACTIVE)
         @log_msg = "Language "+ (params[:id].present? ? @language.name : "") +" status is updated to 'active' from 'unconfirmed'"     #log message
         
      end
      
   @languages = Language.all
   @unconfirmed_languages = Language.where(:status => LANGUAGE_STATUS_UNCONFIRMED)
   render :partial => 'languages', :locals => {:languages => @languages , :unconfirmed_languages => @unconfirmed_languages, :languages_flag => nil }
     
  end
  
  #=====================================================================================================================
  #Objective : to change unconfirmed language status to deleted & users language
  #Input     : @active_language(id of active language),
  #            @unconfirmed_language(id of unconfirmed language)
  #Output    : language status is changed from 'unconfirmed' to 'deleted' & language name of user is replace with 
  #            language whose status is active
  #=====================================================================================================================
  def change_language_status_to_deleted
    @active_language = Language.find_by_name(params[:language_selected]) 
   if Language.find_by_name(params[:language_selected])
        @unconfirmed_language = Language.find(params[:language_selected_id])
        
          if @unconfirmed_language
             @unconfirmed_language.update_attributes(:status => "deleted")
             @log_msg = "Language "+ (params[:language_selected_id].present? ? @unconfirmed_language.name : "") +" status is updated to 'deleted' from 'unconfirmed'"    #log message         
          end
          
        @unconfirmed_language_id = @unconfirmed_language.id
        @user=UserLanguage.where(:language_id => @unconfirmed_language_id).first
    
          if @user
             @user.update_attributes(:language_id => @active_language.id)
             @log_msg = "Language "+ (params[:language_selected_id].present? ? @unconfirmed_language.name : "")+ " of user is replace with language "+ (params[:language_selected].present? ? @active_language.name : "") +" whose status is active"      #log message         
          end
          
              flag = false
      else
              flag = true
             @log_msg = "Language is not present in database"                                                                                                              #log message         
          
    end
   
    @languages = Language.all
    @unconfirmed_languages = Language.where(:status => LANGUAGE_STATUS_UNCONFIRMED)
    render :partial => 'languages', :locals => {:languages => @languages , :unconfirmed_languages => @unconfirmed_languages, :languages_flag => flag}
    
  end

  #=====================================================================================================================
  #Objective : to create new language
  #Input     : @language(inputs to create new language)
  #Output    : new language is created/added 
  #=====================================================================================================================
  def create_language
    @language = Language.new(params[:language]) if params[:language].present?
   
    if @language.save
        #redirect_to(:action => 'languages', :controller => "database_managements")
        @log_msg = "New IT Skill "+ (params[:language].present? ? @language.name : "")+ " is created"                      #log message
    else
        #redirect_to(:action => 'languages', :controller => "database_managements")
        @log_msg = "New IT Skill "+ (params[:language].present? ? @language.name : "")+ " is not created"                 #log message
    end 
     
    @languages = Language.all
    @unconfirmed_languages = Language.where(:status => LANGUAGE_STATUS_UNCONFIRMED)
    partial_locals = {:languages => @languages , :unconfirmed_languages => @unconfirmed_languages, :languages_flag => nil}
    render :partial => 'layouts/conditional_popup_display', :locals => {:partial_tobe_rendered => "languages", :partial_locals => partial_locals, :modal_id => "qualification_language", :button_caption => params[:commit] }
   
  end
  
  
  #=====================================================================================================================
  # =>                                  For AutoComplete                                                
  #=====================================================================================================================
  
  #=====================================================================================================================
  # objective: AutoComplete for Company which returns only status active & client company
  # inputs: params variable terms which contain user input string
  # output: it return chars matching company name 
  #=====================================================================================================================
  def autocomplete_company_name
    term = params[:term]
    if term && !term.empty?
        active_company = Company.where(:status => ["active","client"]) 
        items = active_company.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  #=====================================================================================================================
  # objective: AutoComplete for qualification type which returns only status active qualification type
  # inputs: params variable terms which contain user input string
  # output: it return chars matching qualification type name 
  #=====================================================================================================================
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
  
  #=====================================================================================================================
  # objective: AutoComplete for qualification location which returns only status active location 
  # inputs: params variable terms which contain user input string
  # output: it return chars matching qualification location name 
  #=====================================================================================================================
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
  
  
  #=====================================================================================================================
  # objective: AutoComplete for qualification subject which returns only status active qualification subject
  # inputs: params variable terms which contain user input string
  # output: it return chars matching qualification subject name 
  #=====================================================================================================================
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
  
  
  #=====================================================================================================================
  # objective: AutoComplete for qualification grade which returns only status active qualification grade
  # inputs: params variable terms which contain user input string
  # output: it return chars matching qualification grade name 
  #=====================================================================================================================
  def autocomplete_qualification_grade_name
    term = params[:term]
    if term && !term.empty?
        active_qualification_grade = QualificationGrade.where(:status => "active")
        items = active_qualification_grade.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  #=====================================================================================================================
  # objective: AutoComplete for It Skill which returns only status active It skill name
  # inputs: params variable terms which contain user input string
  # output: it return chars matching it skills name 
  #=====================================================================================================================
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
  
  #=====================================================================================================================
  # objective: AutoComplete for Language which returns only status active Language name
  # inputs: params variable terms which contain user input string
  # output: it return chars matching languages name 
  #=====================================================================================================================
  def autocomplete_language_name
    term = params[:term]
    if term && !term.empty?
        active_languages = Language.where(:status => "active")
        items = active_languages.select("distinct name as description").where("LOWER(name) like ? ", '%' + term.downcase + '%').limit(10).order(:name)
    else
       items = {}
    end
     render :json => json_for_autocomplete(items, :description)
  end
  
  
end
