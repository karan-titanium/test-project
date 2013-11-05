class SettingCategory < ActiveRecord::Base
  
  attr_accessible :name
  
#--- Relations ---#
  has_many :system_settings
  

  
#--- Validations ---#
  validates :name, :presence => true

  
  
#--- Call Backs  ---#
  before_destroy :check_for_system_settings

  
  
#--- Actions ---#

  private

  def check_for_system_settings
    if self.system_settings.count > 0
      errors.add(:base, "cannot delete setting category while system settings exist")
      return false
    end
  end

  
end
