class Role < ActiveRecord::Base
  
  attr_accessible :name
  

  #--- Relations ---#
  #has_many :role_users
  #has_many :users, :through => :role_users
  
  has_many :role_permissions
  has_many :permissions, :through => :role_permissions
  
  has_many :users
  #has_and_belongs_to_many :permissions
  
  
  #--- Validations ---#
  validates :name, :presence => true
  
  
  #--- Call Backs  ---#
  before_destroy :check_for_users_and_permissions
  
  
  #--- Actions ---#
  private

  def check_for_users_and_permissions
    if self.role_users.count > 0 || self.role_permissions.count > 0
      errors.add(:base, "cannot delete role while users exist")  if self.role_users.count > 0
      errors.add(:base, "cannot delete role while permissions exist")  if self.role_permissions.count > 0
      return false
    end
  end
  
end
