class RoleUser < ActiveRecord::Base
  
  attr_accessible :role_id, :user_id
  

  #--- Relations ---#
  belongs_to :role
  belongs_to :user
  
  
  #--- Validations ---#
  validates :role_id, :presence => true
  validates :user_id, :presence => true
  
  
end
