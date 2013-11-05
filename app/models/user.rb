class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable, :omniauthable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2, :linkedin]

  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :status, :user_type, :role_id, :user_profile_attributes, :user_companies_attributes, :last_updated_at, :user_traits_attributes
  before_save :change_status 
  after_create :default_updated_date
  # has_paper_trail
  #--- Scopes ---#
  # scope :candidates, where(:user_type => USER_TYPE_CONTACT)   #TODO: condition is written temporarily & make constant for "contact"
  # scope :staffs, where(:user_type => USER_TYPE_STAFF)


  #--- Relations ---#
  
  has_many :log_systems
  
  has_many :services, :dependent => :destroy
  
  has_many :user_qualifications, :dependent => :destroy
  
  has_many :user_otherskills, :dependent => :destroy
  
  has_one :user_profile, :dependent => :destroy
  accepts_nested_attributes_for :user_profile
  
  has_many :user_companies
  accepts_nested_attributes_for :user_companies  
  
  has_many :companies, :through => :user_companies
  
  has_many :user_languages
  
  has_many :languages, :through => :user_languages
  
  has_many :user_itskills
  
  has_many :itskills, :through => :user_itskills
  
  has_many :user_files
  
  has_many :cdn_files, :through => :user_files
  
  has_many :user_campaigns
  has_many :campaigns, :through => :user_campaigns
  
  has_many :transcript_requests
  
  has_many :user_traits, :dependent => :destroy
  accepts_nested_attributes_for :user_traits
  
  has_many :traits, :through => :user_traits
  
  has_many :user_exams
  has_many :exams, :through => :user_exams
  
  has_many :notes
  
  belongs_to :role

  has_many :given_interviews, :class_name => 'Interview', :foreign_key => 'candidate'
  has_many :taken_interviews, :class_name => 'Interview', :foreign_key => 'interviewer'
 
  #--- Validations ---#
  validates_inclusion_of :user_type, :in => [ USER_TYPE_CONTACT, USER_TYPE_STAFF ]
  validates_inclusion_of :status, :in => USER_STATUS_LIST

  # Email_REGEX =  /^[\\w-+]+(?:\\.[\\w-+]+)*@(?:[\\w-]+\\.)+[a-zA-Z]{2,7}$/
  # validates :email, :format => { :with =>  }
  # Email_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,3}$/i
  # validates :email, :length => {:maximum => 256}, :format => { :with => Email_REGEX }, :uniqueness =>true
  # validates_format_of :email, :with=>Email_REGEX, :message=>"new error message here" 
  if ActiveRecord::Base.connection.table_exists? 'system_settings'
    validates :first_name, :length => {:maximum => 50}, :presence => { :message => Settings.e_user_first_name_blank_message } 
    validates :last_name, :length => {:maximum => 50}, :presence => { :message => Settings.e_user_last_name_blank_message }
    validates :email, :length => {:maximum => 256, :message => Settings.e_user_email_too_long_message }, :uniqueness =>true
  end
  # validates :password, :presence => { :message => (m = SystemSetting.find_by_key('e_user_password_blank_message')).present? ? m.value : "*"  }, :length => { :minimum => 8,:maximum => 23, :message =>  (m = SystemSetting.find_by_key('e_user_password_length_message')).present? ? m.value : "*" }, :confirmation => { :message => (m = SystemSetting.find_by_key('e_user_password_confirmation_message')).present? ? m.value : "*"  } 
  # validates :password_confirmation, :confirmation => { :message => (m = SystemSetting.find_by_key('e_user_password_confirmation_message')).present? ? m.value : "*"  } ,:presence => true
  # validates :last_name, :length => {:maximum => 50}, :presence => { :message => "please enter last name" }  
  validates :user_type, :presence => { :message => "please enter type" }

  #--- Actions ---#
  # This decides which user can be authenticated depending on its status  
  def active_for_authentication?
    super && self.status == USER_STATUS_ACTIVE
  end
  
  # This sets user inactive message if deleted then it shows :user_deleted from config/locales.devise.en.yml else inactive from same file       
  def inactive_message
    self.status == USER_STATUS_DELETED ? :user_deleted : super
  end
  
  # This method change the status of the user from pending to active if he is confirming account  
  def change_status
     self.status = USER_STATUS_ACTIVE if (self.status == USER_STATUS_PENDING && self.confirmed?)
  end

  def default_updated_date
    self.update_attributes(:last_updated_at => self.created_at)
  end

#######################################################################################################################
# Objective: To check a requested user is Staff or not   
# Input: Call with User object
# Output: Checks a requested user is Staff or not & if Staff then returns True otherwise False
#######################################################################################################################  
  def is_staff?
    self.user_type.casecmp(USER_TYPE_STAFF) == 0
  end
  


#######################################################################################################################
# Objective: To get all the staff users with non deleted status    
# Input: Call with User object
# Output: Returns all the staff users with non deleted status
#######################################################################################################################  
  def self.staff_users
    User.where('user_type = :t AND status <> :s', t: USER_TYPE_STAFF, s: USER_STATUS_DELETED)
  end
  
  def client_company
    if !self.user_companies.empty?
        self.user_companies.each do |uc|
          return uc.company if uc.clientcontact?
        end
        return false
    else
      false
    end  
  end

#######################################################################################################################
# Objective: To get full name of a requested User    
# Input: Call with User object
# Output: Returns full name of a requested User
#######################################################################################################################  
  def full_name
    full_name = ""
    full_name << first_name  if first_name.present?
    full_name << (" " + last_name)  if last_name.present?
  end
  
#======================================================================================================================
# Objective: To check current user is candidate     
# Input: nothing
# Output: it return true if current user is candidate else false
#======================================================================================================================  
   
  def is_candidate?
    flag = true
    if self.user_type.casecmp(USER_TYPE_CONTACT) == 0 
      if !self.user_companies.empty?
        self.user_companies.each do |company|
          return flag = false if company.clientcontact?
        end
      end  
    else
      flag = false
    end  
    flag
  end 
  
#======================================================================================================================
#======================================================================================================================  
  
  def is_client?
    flag = false
    if self.user_type.casecmp(USER_TYPE_CONTACT) == 0 
      if !self.user_companies.empty?
        self.user_companies.each do |company|
          return flag = true if company.clientcontact?
        end
      end  
    else
      flag = false
    end  
    flag
  end


#======================================================================================================================
# Objective: To send incomplete profile reminders to candidate     
# Input: nothing
# Output: it send mail to user for incomplete profile and return nothing
#======================================================================================================================  
 
  def self.send_incomplete_profile_reminders
    users = User.where(:user_type => USER_TYPE_CONTACT)
    first_reminder_day = (ss = SystemSetting.find_by_key('e_candidate_profile_reminder1')).present? ? ss.value.to_i : 1 
    second_reminder_day = (ss = SystemSetting.find_by_key('e_candidate_profile_reminder2')).present? ? ss.value.to_i : 2
    third_reminder_day = (ss = SystemSetting.find_by_key('e_candidate_profile_reminder3')).present? ? ss.value.to_i : 3
    
    template = EmailTemplate.find_by_name('Incomplete profile')
    users.each do |user|
      puts "=============================== START ========================"
      puts "user email -"+user.email
      
      user_profile = user.user_profile
      user_profile = user.build_user_profile if !user_profile.present?
      user_profile_complete = User.user_profile_is_complete?(user)
      last_update = user.last_updated_at.to_date

      if !user_profile_complete 
          if  user_profile.reminderemail1.present? && user_profile.reminderemail2.present? && user_profile.reminderemail3.present?
              puts "============== for Inactive ==========================="
                if last_update < user_profile.reminderemail3.to_date &&  (Time.now.to_date - user_profile.reminderemail3.to_date) >= first_reminder_day
                  user.status = USER_STATUS_INACTIVE
                  puts "inactivete user"
                elsif last_update > user_profile.reminderemail3.to_date
                  user_profile.reminderemail1 = nil
                  user_profile.reminderemail2 = nil
                  user_profile.reminderemail3 = nil
                  puts "reminder1  reminder2 and reminder3 nil"
                else
                  puts "no action"
                end
                
              puts "============== End for Inactive ==========================="   
          elsif user_profile.reminderemail1.present? && user_profile.reminderemail2.present? && !user_profile.reminderemail3.present?
              puts "============== for 3rd ==========================="
              
                if last_update < user_profile.reminderemail2.to_date &&  (Time.now.to_date - user_profile.reminderemail2.to_date) >= third_reminder_day
                  UserMailer.send_incomplete_profile_reminders(template, user).deliver
                  user_profile.reminderemail3 = DateTime.now
                  puts "third reminder mail sent"
                elsif last_update > user_profile.reminderemail2.to_date
                   user_profile.reminderemail1 = nil
                   user_profile.reminderemail2 = nil
                   puts "reminder1  and reminder2 nil"  
                else
                   puts "No mail sent"
                end
              
              puts "============== End for 3rd ==========================="  
          elsif user_profile.reminderemail1.present? && !user_profile.reminderemail2.present? && !user_profile.reminderemail3.present?
              
              puts "============== for 2nd ==========================="
                
                if last_update < user_profile.reminderemail1.to_date &&  (Time.now.to_date - user_profile.reminderemail1.to_date) >= second_reminder_day
                  UserMailer.send_incomplete_profile_reminders(template, user).deliver
                  user_profile.reminderemail2 = DateTime.now
                  puts "second reminder mail sent"
                elsif last_update > user_profile.reminderemail1.to_date
                   user_profile.reminderemail1 = nil
                   puts "reminder1 nil"  
                else
                   puts "No mail sent"
                end
                  
              puts "============== End for 2nd ==========================="
              
          elsif !user_profile.reminderemail1.present? && !user_profile.reminderemail2.present? && !user_profile.reminderemail3.present?
              
              puts "============== for 1st ==========================="
              
              if (Time.now.to_date - last_update) >= first_reminder_day
                UserMailer.send_incomplete_profile_reminders(template, user).deliver
                user_profile.reminderemail1 = DateTime.now
                puts "first reminder mail sent"
              else
                puts "No mail sent"  
              end
              
              puts "============== End for 1st ==========================="    
          end 
       end   

       user.save    
       puts "============================== End ========================="
    end
    
  end 
  
#==================================================================================================  
#=================================================================================================  
  def self.user_profile_is_complete?(user)
    flag = true
    if !UserProfile.work_eligibility_completely_filled?(user)
        flag = false      
    elsif !UserProfile.personal_details_completely_filled?(user)
        flag = false
    elsif !UserProfile.employment_details_completely_filled?(user)
        flag = false
    elsif !UserProfile.upload_cv_completely_filled?(user)
        flag = false
    elsif !UserProfile.online_test_completely_filled? user
        flag = false
    elsif !UserProfile.qualification_completely_filled? user
        flag = false
    elsif !UserProfile.skills_completely_filled? user
        flag = false
    else
        flag = true
    end    
    flag
  end
  
#==================================================================================================
# OBJECTIVE => TO return all active campaigns for which candidate not applied
# INPUT => user
# OUTPUT =>  list of active campaigns
#=================================================================================================   
  def non_applied_active_campaigns
    active_campaigns = Campaign.where(:status => CAMPAIGN_STATUS_ACTIVE)
    campaigns_id = self.user_campaigns.pluck(:campaign_id)
    non_applied_active_campaigns = []
    
    if campaigns_id.present?
      active_campaigns.each do | camp |
        non_applied_active_campaigns << camp if !campaigns_id.include?(camp.id)
      end if active_campaigns.present?
    else
      non_applied_active_campaigns = active_campaigns 
    end  
    non_applied_active_campaigns
  end
end
