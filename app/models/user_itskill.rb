class UserItskill < ActiveRecord::Base
  attr_accessible :experience, :itskill_id, :level, :user_id, :it_skill_name
  
  #=========================================== Database Relation (Active model)========================================================
  belongs_to :user
  belongs_to :itskill
 
  #=========================================== validations ============================================================================
  validates :user_id, :presence => true
  validates :itskill_id, :presence => true
  validates :experience, :presence => {:message => Settings.e_field_mandatory }, :numericality => { :message => Settings.e_field_numeric }
  validates :experience, :length => { :maximum => 5, :message => Settings.e_numericfield_length5 } 
  validates :level, :presence => {:message => Settings.e_field_mandatory }
  validates_inclusion_of :level, :in => SKILL_LEVEL_LIST
  
  #=========================================== ACtions ==================================================================================== 
  def it_skill_name
    itskill.name if itskill present?
  end
  
  def it_skill_name=(name)
   	self.itskill = Itskill.find_or_create_by_name(name) unless name.blank?
 	end
end
