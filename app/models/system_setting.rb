class SystemSetting < ActiveRecord::Base
  
  attr_accessible :key, :name, :description, :value, :setting_type, :editable, :setting_category_id 
  
  #--- Relations ---#
  belongs_to :setting_category
  
  
  #--- Scopes ---#
  scope :editable_settings, where(:editable => true)
  
  
  #--- Validations ---#
  validates :key, :presence => true, :uniqueness => true
  validates :name, :presence => true, :length => {:maximum => 50}
  validates :description, :presence => true, :length => {:maximum => 256}
  validates :value, :presence => true
  validates :setting_type, :presence => true
  validates :setting_category_id, :presence => true
  validates_inclusion_of :editable, :in => [true, false]
  validates_inclusion_of :setting_type, :in => SETTING_TYPE_LIST
    
end

