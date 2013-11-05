class UserLanguage < ActiveRecord::Base
  attr_accessible :language_id, :spoken, :user_id, :written, :language_name
  
  #=========================================== Database Relation (Active model) ======================================================
  belongs_to :user
  belongs_to :language  
  
  
  #=========================================== validations ============================================================================
  validates :user_id, :presence => true
  validates :language_id, :presence => {:message => Settings.e_field_mandatory }
  validates :spoken, :presence => {:message => Settings.e_field_mandatory }
  validates :written, :presence => {:message => Settings.e_field_mandatory }
  validates_inclusion_of :spoken, :in => LANGUAGE_LEVEL_LIST
  validates_inclusion_of :written, :in => LANGUAGE_LEVEL_LIST
  
  #=========================================== Actions ============================================================================
  def language_name
    language.name if language present?
  end
  
  def language_name=(name)
    self.language = Language.find_by_name(name) unless name.blank?
  end
  
end
