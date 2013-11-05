class Permission < ActiveRecord::Base
  
  attr_accessible :name, :description, :subject_class, :action
  

  #--- Relations ---#
  has_many :role_permissions
  has_many :roles, :through => :role_permissions
  
  
  #--- Validations ---#
  #validates :role_id, :presence => true
  #validates :user_id, :presence => true
  
end
