class UserOtherskill < ActiveRecord::Base
  attr_accessible :experience, :level, :skill, :user_id
  
  #===================================== Database Relation (Active model) ============================================================
  belongs_to :user
  
  #===================================== validations ================================================================================
  validates :user_id, :presence => true
  validates_length_of :skill, :within => 1..250, :too_short => Settings.e_field_mandatory, :too_long => Settings.e_fieldlength_250
  validates :experience, :presence => {:message => Settings.e_field_mandatory }, :numericality => { :message => Settings.e_field_numeric }
  validates :experience, :length => { :maximum => 5, :message => Settings.e_numericfield_length5 }
  validates :level, :presence => {:message => Settings.e_field_mandatory }
  validates_inclusion_of :level, :in => SKILL_LEVEL_LIST
end
