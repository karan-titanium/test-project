class UserQualification < ActiveRecord::Base
  attr_accessible :qualification_grade_id, :qualification_location_id, :qualification_subject_id, :qualification_type_id, :user_id, :year,
                  :qualification_name, :school_loc_name, :subject_name, :grade_name
  
  #=========================================== Database Relation (Active model)===============================================
  belongs_to :user
  belongs_to :qualification_subject
  belongs_to :qualification_type
  belongs_to :qualification_location
  belongs_to :qualification_grade
  
  # accepts_nested_attributes_for :qualification_grade, :qualification_location, :qualification_subject, :qualification_type
  # attr_accessible :qualification_grade_attributes, :qualification_location_attributes, :qualification_subject_attributes, :qualification_type_attributes
  
  #=========================================== validations =====================================================================
  validates :user_id, :presence => true
	validates :year, :presence => {:message => Settings.e_field_mandatory }
  validates :year, :format => { :with => /^\d{4,4}$/i, :message => Settings.e_yearformat  }
  validates :qualification_name, :presence => {:message => Settings.e_field_mandatory }
  validates :school_loc_name, :presence => {:message => Settings.e_field_mandatory }
  validates :subject_name, :presence => {:message => Settings.e_field_mandatory }
  validates :qualification_grade_id, :presence => {:message => Settings.e_field_mandatory }
  
  
  #=========================================== Actions =====================================================================
  def qualification_name
    qualification_type.name if qualification_type.present? 
  end
  
  def qualification_name=(name)
    self.qualification_type = QualificationType.find_or_create_by_name(name) unless name.blank?
  end
  
  def school_loc_name
    qualification_location.name if qualification_location.present? 
  end
  
  def school_loc_name=(name)
    self.qualification_location = QualificationLocation.find_or_create_by_name(name) unless name.blank?
  end
  
  def subject_name
    qualification_subject.name if qualification_subject.present? 
  end
  
  def subject_name=(name)
    self.qualification_subject = QualificationSubject.find_or_create_by_name(name) unless name.blank?
  end
  
  def grade_name
    qualification_grade.name if qualification_grade.present? 
  end
  
  def grade_name=(name)
    self.qualification_grade = QualificationGrade.find_or_create_by_name(name) unless name.blank?
  end
end
