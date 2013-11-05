class QualificationSubject < ActiveRecord::Base
  attr_accessible :name, :status
  
  #============================================ Database Relation (Active model)  ====================================================
  has_one :user_qualification 
  
  #============================================= Callback =========================================================================
  before_validation :default_values
  
  #============================================ validates============================================================================
  # validate :status, :presence =>{:message => (ss = SystemSetting.find_by_key('e_field_mandatory')).present? ? ss.value : "*"  }
  #validates_inclusion_of :status, :in => QUALIFICATION_SUBJECT_STATUS_LIST
  validates :name, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50 }
  validates :status, :presence => { :message => Settings.e_field_mandatory }, :inclusion => { :in => QUALIFICATION_SUBJECT_STATUS_LIST.map{|k,v| k}, :case_sensitive => false }
  
  
  #============================================ Actions ============================================================================
  
  #=======================================================================================================================
  # Objective: To set the default values for fields of Qualification Subject table   
  # Input:
  # Output: Sets the default values for some fields of Qualification Subject table
  #======================================================================================================================== 
  def default_values
    self.status = QUALIFICATION_SUBJECT_STATUS_UNCONFIRMED if !self.status.present?
  end
  
end
