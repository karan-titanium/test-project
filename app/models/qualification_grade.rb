class QualificationGrade < ActiveRecord::Base
  attr_accessible :name, :qualification_type_id, :status , :order
  
  # Database Relation (Active model)
  has_one :user_qualification
  belongs_to :qualification_type
  
  #============================================= Callback =========================================================================
  before_validation :default_values
  
  #============================================ validates============================================================================
  #validate :status, :presence =>{:message => (ss = SystemSetting.find_by_key('e_field_mandatory')).present? ? ss.value : "*"  }
  #validates_inclusion_of :status, :in => QUALIFICATION_STATUS_LIST
  validates :qualification_type_id, :presence => { :message => Settings.e_field_mandatory }
  validates :status, :presence => { :message => Settings.e_field_mandatory }, :inclusion => { :in => QUALIFICATION_GRADE_STATUS_LIST.map{|k,v| k}, :case_sensitive => false }
  validates :name, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50 }
  validates :order, :numericality => { :message => Settings.e_field_numeric }, :allow_blank => true , :length => {:maximum => 5, :message => Settings.e_numericfield_length5 }
  
  
  #============================================ Actions ============================================================================
  
  #=======================================================================================================================
  # Objective: To set the default values for fields of Qualification Grade table   
  # Input:
  # Output: Sets the default values for some fields of Qualification Grade table
  #======================================================================================================================== 
  def default_values
    self.status = QUALIFICATION_GRADE_STATUS_UNCONFIRMED if !self.status.present?
  end
end