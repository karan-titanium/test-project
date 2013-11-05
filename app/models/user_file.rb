class UserFile < ActiveRecord::Base
  attr_accessible :cdn_file_id, :user_file_type, :user_id
  
  # Database Relation (Active model)
  belongs_to :user
  belongs_to :cdn_file
  
  # validations
  validates :cdn_file_id, :presence => {:message => Settings.e_field_mandatory }
  validates :user_file_type, :presence => {:message => Settings.e_field_mandatory }
  validates :user_id, :presence => {:message => Settings.e_field_mandatory }
  validates_inclusion_of :user_file_type, :in => FILE_TYPE_LIST 
end
