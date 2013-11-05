class ContactLog < ActiveRecord::Base
  
  attr_accessible :from, :to, :campaign_id, :method, :datecontact, :subject, :details, :contact_attachments_attributes, :cdn_files_attributes
                                                                                        
                                                                                        
#--- Relations ---#
  belongs_to :campaign
  
  has_many :contact_attachments, :dependent => :destroy
  accepts_nested_attributes_for :contact_attachments, :reject_if => :all_blank
  
  has_many :cdn_files, :through => :contact_attachments 
  accepts_nested_attributes_for :cdn_files, :reject_if => proc { |a| a['cf_filename'].blank? }  


#--- Validations ---#
  validates :from, :presence => {:message => Settings.e_field_mandatory}
  validates :to, :presence => {:message => Settings.e_field_mandatory}
  validates :method, :presence => {:message => Settings.e_field_mandatory}, :inclusion => { :in => CONTACT_LOG_METHOD_LIST.map{|k,v| k}, :case_sensitive => false }
  validates :datecontact, :presence => {:message => Settings.e_field_mandatory}
  validates :subject, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}
  validates :details, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 256, :message => Settings.e_fieldlength_256}
  
end
