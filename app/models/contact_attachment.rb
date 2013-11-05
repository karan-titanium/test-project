class ContactAttachment < ActiveRecord::Base
  
  attr_accessible :contact_log_id, :private, :cdn_file_id
  
  
  #--- Relations ---#
  belongs_to :contact_log
  belongs_to :cdn_file
  
  
  #--- Validations ---#
  validates :contact_log_id, :presence => true
  validates :cdn_file_id, :presence => true
  
end
