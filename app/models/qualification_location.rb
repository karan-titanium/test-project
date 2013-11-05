class QualificationLocation < ActiveRecord::Base
  attr_accessible :name, :status
  
  
  #============================================= Database Relation (Active model)===================================================
  has_one :user_qualification
  
  #============================================= Callback =========================================================================
  before_validation :default_values
  
  #============================================ validates============================================================================
  #validates_inclusion_of :status, :in => QUALIFICATION_LOCATION_STATUS_LIST
  validates :name, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50 }
  validates :status, :presence => { :message => Settings.e_field_mandatory }, :inclusion => { :in => QUALIFICATION_LOCATION_STATUS_LIST.map{|k,v| k}, :case_sensitive => false }
  
  
  #=======================================================================================================================
  # Objective: To set the default values for fields of Qualification Location table   
  # Input:
  # Output: Sets the default values for some fields of Qualification Location table
  #=======================================================================================================================
  def default_values
    self.status = QUALIFICATION_LOCATION_STATUS_UNCONFIRMED if !self.status.present?
  end
  
end
