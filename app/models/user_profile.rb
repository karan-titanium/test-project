class UserProfile < ActiveRecord::Base
  extend FriendlyId
  
  attr_accessible :address_country, :address_line1, :address_line2, :address_postcode, :address_town, :contact_method, 
                  :contact_time, :eligabledetails, :eligableuk, :gender, :number_alt, :number_mob, :passport, :photo, 
                  :salary_current, :salary_target, :user_id, :uk_driving_licence, :employed, :date_of_birth, :reminderemail1, :reminderemail2, :reminderemail3 
  has_paper_trail
  # Database Relation (Active model)
  belongs_to :user
  belongs_to :cdn_file, :foreign_key => :photo
  
  serialize :contact_time, Array
  # accepts_nested_attributes_for :user_qualification
  # attr_accessible :user_qualification_attributes
#   
  # accepts_nested_attributes_for :user
  # attr_accessible :user_attributes
  
  # ======================================validations=============================
  validates_length_of :address_line1, :address_line2, :maximum => 100, :too_long => (ss = SystemSetting.find_by_key('e_fieldlength_100')).present? ? ss.value : "*" 
  validates_length_of :address_town, :maximum => 50, :too_long => (ss = SystemSetting.find_by_key('e_fieldlength_50')).present? ? ss.value : "*"
  validates_length_of :eligabledetails, :maximum => 250, :too_long => (ss = SystemSetting.find_by_key('e_fieldlength_250')).present? ? ss.value : "*",  :allow_blank => true 
  validates :number_mob, :format => { :with => REGX_MOBILE, :message => (ss = SystemSetting.find_by_key("e_mobile_alternate_number")).present? ? ss.value : "*" },  :allow_blank => true 
  validates :number_alt,  :format => { :with => REGX_PHONE_NUMBER, :message => (ss = SystemSetting.find_by_key("e_mobile_alternate_number")).present? ? ss.value : "*"  },  :allow_blank => true
  validates :salary_current, :numericality => {:message => (ss = SystemSetting.find_by_key('e_userprofile_salary')).present? ? ss.value : "*" }, :allow_blank => true 
  validates :salary_target, :numericality => {:message => (ss = SystemSetting.find_by_key('e_userprofile_salary')).present? ? ss.value : "*" }, :allow_blank => true
  validates_length_of :salary_current, :salary_target, :maximum => 11, :too_long => (ss = SystemSetting.find_by_key('e_numericfield_length11')).present? ? ss.value : "*"  
  validates :address_postcode, :format => { :with => REGX_POSTCODE, :message =>(ss = SystemSetting.find_by_key('e_postcode')).present? ? ss.value : "*" }, :allow_blank => true
  validates :eligabledetails, :presence => { :message => Settings.e_field_mandatory }, :if => :not_eligable_work_in_uk
  
#==================================================================================
# Objective => To provide conditional presence validation for eligible details 
# Input => Noting
# Output => return true or false depends on value of eligibleuk and passport
#==================================================================================  
  def not_eligable_work_in_uk
    self.eligableuk == "no" && self.passport == "no"
  end
  
#==================================================================================
# Objective => To check work eligibility section is completely filled or not 
# Input => Noting
# Output => return true or false 
#================================================================================== 
  def self.work_eligibility_completely_filled? user
     user_profile = user.user_profile
     flag = true
     if "yes".casecmp(user_profile.passport.present? ? user_profile.passport : "") == 0
       
     elsif user_profile.passport == "no"
       if user_profile.eligableuk == "no"
         flag = user_profile.eligabledetails.present?
       end 
     else 
       flag = false  
     end   
     flag
  end

#==================================================================================
# Objective => To check personal details section is completely filled or not 
# Input => Noting
# Output => return true or false
#==================================================================================  
  def self.personal_details_completely_filled? user
    user_profile = user.user_profile
    personal_hash = {
            :first_name => user.first_name, 
            :last_name => user.last_name,
            :gender => user_profile.gender,
            :email => user.email,
            :mobil => user_profile.number_mob,
            :alter => user_profile.number_alt,
            :cont_meth =>  user_profile.contact_method,
            :cont_time =>  user_profile.contact_time,   
            :add_country =>  user_profile.address_country,
            :add_line1 => user_profile.address_line1, 
            :add_line1 => user_profile.address_line2, 
            :add_postcode => user_profile.address_postcode, 
            :add_town => user_profile.address_town  
          }
    personal_hash.values.all? {|x| !x.nil? && !x.blank? }
  end

#==================================================================================
# Objective => To check employment details section is completely filled or not 
# Input => Noting
# Output => return true or false
#==================================================================================  
  def self.employment_details_completely_filled? user
    user_profile = user.user_profile
    flag = true
    if user_profile.employed && user_profile.employed == "yes"
      flag = ( user.user_companies.where(:current => true).present? && user_profile.salary_current.present? && user_profile.salary_target.present? )
    else
      flag =  user_profile.salary_target.present?
    end  
    flag
  end

#==================================================================================
# Objective => To check cv section is completely filled or not 
# Input => Noting
# Output => return true or false
#==================================================================================  
  def self.upload_cv_completely_filled? user
    user.user_files.where(:user_file_type => "cv").present?
  end

#==================================================================================
# Objective => To check online test section is completely filled or not 
# Input => Noting
# Output => return true or false
#==================================================================================  
  def self.online_test_completely_filled? user
      return true    
  end

#==================================================================================
# Objective => To check qualification section is completely filled or not 
# Input => Noting
# Output => return true or false
#==================================================================================  
  def self.qualification_completely_filled? user
    user.user_qualifications.present?
  end

#==================================================================================
# Objective => To check skills section is completely filled or not 
# Input => Noting
# Output => return true or false
#==================================================================================  
  def self.skills_completely_filled? user
    user.user_itskills.present? && user.user_otherskills.present? && user.user_languages.present?
  end
end
