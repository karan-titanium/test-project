class LogSystem < ActiveRecord::Base
  
  attr_accessible :event_type, :user_id, :ip, :message, :controller, :action
  
  #--- Relations ---#
  belongs_to :user
  
  #--- Validations ---#
  validates :event_type, :presence => true
  validates :user_id, :presence => true
  validates :ip, :presence => true
  
end
