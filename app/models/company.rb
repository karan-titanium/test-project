class Company < ActiveRecord::Base
  attr_accessible :name, :status, :phone, :website, :address_line1, :address_line2, :address_town, :address_country, :address_postcode,
                  :contact, :whitelabel, :subdomain, :displayname, :profile, :logo
  
  attr_accessor :whitelabel
  
  
  
#--- Relations ---#
  has_many :user_companies
  has_many :users, :through => :user_companies
  
  has_many :campaigns

  belongs_to :cdn_file
  
  

#--- Callback ---#
  before_validation :default_values   
  before_save :set_white_labeling
  


#--- Scopes ---#
  scope :non_deleted_companies, where('status <> :s', s: COMPANY_STATUS_DELETED)
  
  

#--- Validations ---#
  validates :name, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50 }
  validates :status, :presence => { :message => Settings.e_field_mandatory }, :inclusion => { :in => COMPANY_STATUS_LIST.map{|k,v| k}, :case_sensitive => false }
  validates :phone, :format => { :with => REGX_PHONE_NUMBER, :message => Settings.e_mobile_alternate_number }, :allow_blank => true
  validates :address_postcode, :format => { :with => REGX_POSTCODE, :message => Settings.e_postcode }, :allow_blank => true
  validates :address_line1, :length => {:maximum => 100, :message => Settings.e_fieldlength_100}, :allow_blank => true
  validates :address_line2, :length => {:maximum => 100, :message => Settings.e_fieldlength_100}, :allow_blank => true
  validates :address_town, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}, :allow_blank => true
  validates :address_country, :inclusion => { :in => COUNTRY_LIST, :case_sensitive => false }, :allow_blank => true
  validates :displayname, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}, :allow_blank => true
  validates :profile, :length => {:maximum => 500, :message => Settings.e_fieldlength_500}, :allow_blank => true
  validates :subdomain, :format => { :with => REGX_COMPANY_SUBDOMAIN, :message => Settings.e_field_subdomain }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}, :uniqueness => true, :allow_blank => true 
  #validates :website, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => Settings.e_field_website },  :allow_blank => true 



#--- Actions ---#

#######################################################################################################################
# Objective: To set the default values for fields of Company table   
# Input:
# Output: Sets the default values for some fields of Company table
#######################################################################################################################  
  def default_values
    #self.whitelabel ||= false      #TODO:
    self.status = COMPANY_STATUS_UNCONFIRMED if !self.status.present?
  end
  


#######################################################################################################################
# Objective: To get all the active campaigns of a company  
# Input: Call with Company object
# Output: Returns all active campaigns of requested company
#######################################################################################################################  
  def active_campaigns
    campaigns.where('campaigns.status = :s', s: CAMPAIGN_STATUS_ACTIVE)
  end
  
  

#######################################################################################################################
# Objective: To get all non deleted campaigns of a company  
# Input: Call with Company object
# Output: Returns all non deleted campaigns of requested company
#######################################################################################################################  
  def non_deleted_campaigns
    campaigns.where('campaigns.status <> :s', s: CAMPAIGN_STATUS_DELETED)
  end
  
  

#######################################################################################################################
# Objective: To get all non deleted contacts of a company  
# Input: Call with Company Object
# Output: Returns all the non deleted users who are currently employed at requested company 
#######################################################################################################################  
  def contacts
    users.where('users.user_type = :t AND users.status <> :s AND user_companies.current = :c', t: USER_TYPE_CONTACT, s: USER_STATUS_DELETED, c: true)
  end
  

  
#######################################################################################################################
# Objective: To get all active contacts of a company 
# Input: Call with Company Object
# Output: Returns all the active users who are currently employed at requested company 
#######################################################################################################################  
  def active_contacts
    users.where('users.user_type = :t AND users.status = :s AND user_companies.current = :c', t: USER_TYPE_CONTACT, s: USER_STATUS_ACTIVE, c: true)
  end



#######################################################################################################################
# Objective: To get a primary contact of a company  
# Input: Call with Company object
# Output: Returns a user who is a primary contact at requested company
#######################################################################################################################  
  def primary_contact
    User.find(self.contact)  if self.contact.present?
  end
  
  

#######################################################################################################################
# Objective: To check whether a requested company is eligible to enable whitelabeling      
# Input: Call with Company object
# Output: Checks whether a requested company is eligible to enable whitelabeling or not & return True if yes otherwise return False
#######################################################################################################################  
  def can_enable_whitelabeling?
    self.subdomain.present? && self.displayname.present? && self.profile.present? && self.logo.present?
  end



#######################################################################################################################
# Objective: To return all the Contact Log entries made for a requested Company  
# Input: Call with Company object
# Output: Returns all the Contact Log entries made for a requested Company
#######################################################################################################################  
  def contact_logs
     ContactLog.where(:to => self.contacts)
  end
  


#######################################################################################################################
# Objective: To return full address of a requested Company  
# Input: Call with Company object
# Output: Returns full address of a requested Company
#######################################################################################################################  
  def full_address
    full_address = ""
    full_address << self.address_line1  if self.address_line1.present?
    full_address << (full_address.present? ? ", " : "") + self.address_line2  if self.address_line2.present?
    full_address << (full_address.present? ? ", " : "") + self.address_town  if self.address_town.present?
    full_address << (full_address.present? ? "- " : "") + self.address_postcode  if self.address_postcode.present?
    full_address << (full_address.present? ? ", " : "") + self.address_country  if self.address_country.present?
    return full_address
  end
  


#######################################################################################################################
# Objective: To set whitelabel true/false according to available information  
# Input: Call with Company object
# Output: Sets whitelabel true/false according to available information
#######################################################################################################################  
  def set_white_labeling
    self.whitelabel = false   if !self.can_enable_whitelabeling?
    return
  end
  
      
end
