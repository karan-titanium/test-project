class QualificationType < ActiveRecord::Base
  attr_accessible :name, :status
 
   
  #============================================ Database Relation (Active model)====================================================
  has_one :user_qualification
  has_one :qualification_grade
  
  #============================================= Callback =========================================================================
  before_validation :default_values
  
  #============================================ validates============================================================================
  #validates_inclusion_of :status, :in => QUALIFICATION_STATUS_LIST
  validates :name, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50 }
  validates :status, :presence => { :message => Settings.e_field_mandatory }, :inclusion => { :in => QUALIFICATION_STATUS_LIST.map{|k,v| k}, :case_sensitive => false }
  
  
  #============================================ Actions ============================================================================
  
  #=======================================================================================================================
  # Objective: To set the default values for fields of Qualification Type table   
  # Input:
  # Output: Sets the default values for some fields of Qualification Type table
  #======================================================================================================================== 
  def default_values
    self.status = QUALIFICATION_STATUS_UNCONFIRMED if !self.status.present?
  end

end
