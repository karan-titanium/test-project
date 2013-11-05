class RolePermission < ActiveRecord::Base
  
  attr_accessible :role_id, :permission_id


  #--- Relations ---#
  belongs_to :role
  belongs_to :permission
  
  
  #--- Validations ---#
  validates :role_id, :presence => true
  validates :permission_id, :presence => true
  
end
