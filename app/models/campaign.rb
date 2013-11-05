class Campaign < ActiveRecord::Base
  
  attr_accessible :date_activated, :date_inactive, :campaign_name, :reference, :status,
                  :company_id, :title, :summary, :details, :deadline_application, :deadline_forward, :campaign_traits_attributes
                  


#--- Relations ---#

  belongs_to :company
  
  has_many :campaign_traits, :dependent => :destroy
  accepts_nested_attributes_for :campaign_traits, :allow_destroy => true
  
  has_many :traits, :through => :campaign_traits
  
  has_many :campaign_exams
  has_many :exams, :through => :campaign_exams
  
  has_many :user_campaigns
  has_many :users, :through => :user_campaigns
  
  has_many :campaign_links
  
  has_many :contact_logs

  

#--- Validations ---#

  validates :campaign_name, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}
  validates :reference, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}
  validates :status, :presence => {:message => Settings.e_field_mandatory}
  validates :company_id, :presence => {:message => Settings.e_field_mandatory}
  validates :title, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}
  validates :summary, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 256, :message => Settings.e_fieldlength_256}
  validates :details, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 500, :message => Settings.e_fieldlength_500}
  validates_inclusion_of :status, :in => CAMPAIGN_STATUS_LIST



#--- Callback ---#

  before_save :check_status


#--- Actions ---#

#######################################################################################################################
# Objective: To get all the candidates applied for a Campaign  
# Input: Call with Campaign object
# Output: Returns all users who has applied for a requested campaign
#######################################################################################################################  
  def candidates_applied
    users.where('users.status <> :s', s: USER_STATUS_DELETED)
  end
  


#######################################################################################################################
# Objective: To get all the candidates who are forwarded to client or rejected for a Campaign  
# Input: Call with Campaign object
# Output: Returns all users who are forwarded to client or rejected for a requested campaign
#######################################################################################################################  
  def candidates_forwarded_or_rejected
    users.where('users.status <> :us AND user_campaigns.status in (:cs)', us: USER_STATUS_DELETED, cs: [USER_CAMPAIGN_STATUS_FORWARDED, USER_CAMPAIGN_STATUS_REJECTED])
  end
  


#######################################################################################################################
# Objective: To get all the candidates who are forwarded to client for a Campaign  
# Input: Call with Campaign object
# Output: Returns all users who are forwarded to client for a requested campaign
#######################################################################################################################  
  def candidates_forwarded
    users.where('users.status <> :us AND user_campaigns.status = :cs', us: USER_STATUS_DELETED, cs: USER_CAMPAIGN_STATUS_FORWARDED)
  end
  
  

#######################################################################################################################
# Objective: TODO:  
# Input:
# Output:
#######################################################################################################################  
  def check_status
    #binding.pry    #TODO: set date_activated/ date_inactive
    return
  end                  


#######################################################################################################################
# Objective: TODO:  
# Input:
# Output:
#######################################################################################################################  
  
  def initial_exam_end_date(contact)
    initial_campaign_exam = CampaignExam.where("campaign_id = ? AND stage = ?", self.id, EXAM_STAGE_INITIAL).first
    
    initial_exam_present = false
    initial_exam_ended_date = false
    
    if initial_campaign_exam.present? 
       initial_exam_present = true
        
       initial_user_exam = UserExam.where("user_id = ? AND exam_id = ?",contact.id, initial_campaign_exam.exam_id).first
       initial_exam_ended_date = (initial_exam_present) ? initial_user_exam.date_end : false
    end
      
    return initial_exam_present, initial_exam_ended_date    
  end

#######################################################################################################################
# Objective: TODO:  
# Input:
# Output:
#######################################################################################################################  
  
  
  def additional_exam_end_date(contact)
    additional_campaign_exam = CampaignExam.where("campaign_id = ? AND stage = ?", self.id, EXAM_STAGE_ADDITIONAL).first
    
    additional_exam_present = false
    additional_exam_ended_date = false
    
    if additional_campaign_exam.present?
       additional_exam_present = true
       
       additional_user_exam = UserExam.where("user_id = ? AND exam_id = ?",contact.id, additional_campaign_exam.exam_id).first
      
       additional_exam_ended_date = (additional_exam_present) ? additional_user_exam.date_end : false if additional_user_exam
    end 
    
    return additional_exam_present, additional_exam_ended_date
  end

#######################################################################################################################
# Objective: TODO:  
# Input:
# Output:
#######################################################################################################################  
  
  def verification_exam_end_date(contact)
    verification_campaign_exam = CampaignExam.where("campaign_id = ? AND stage = ?", self.id, EXAM_STAGE_VERIFICATION).first
    
    verification_exam_present = false
    verification_exam_ended_date = false
    
    if verification_campaign_exam.present? 
       verification_exam_present = true
       
       verification_user_exam = UserExam.where("user_id = ? AND exam_id = ?",contact.id, verification_campaign_exam.exam_id).first
      
       verification_exam_ended_date = (verification_exam_present) ? verificationuser_exam.date_end : false if verification_user_exam.present?
    end
    
    return verification_exam_present, verification_exam_ended_date
  end
end
