class UserCompany < ActiveRecord::Base
  attr_accessible :clientcontact, :company_id, :current, :from, :position, :untill, :user_id, :company_name
  
#========================================= Relations =====================================#
  belongs_to :user
  belongs_to :company
  
  
#========================================= Callback =====================================#
  before_create :make_new_company_current, :default_values    #TODO  check callback
  before_save :default_values   #TODO check callback



#========================================= Validations =====================================#
  validates :company_name, :presence => {:message => Settings.e_field_mandatory }
	#validates :user_id, :presence => {:message => Settings.e_field_mandatory }  #TODO: Note => Do not uncomment this
  validates :position, :length => {:maximum => 50, :message => Settings.e_fieldlength_50}, :allow_blank => true
  #validates :from, :presence => { :message => Settings.e_field_mandatory }
  # validates :untill, :presence => { :message => Settings.e_field_mandatory }, :if => :current_company_false 
#========================================= Actions =====================================#

#========================================================================================================================
# Objective => To make conditional presence true for until date when current for user company is false
# Input =>  current object
# OutPut => true or false 
#========================================================================================================================  
  def current_company_false
    self.current == false  
  end
  
#######################################################################################################################
# Objective: To set the default values for fields of UserCompany table   
# Input:
# Output: Sets the default values for some fields of UserCompany table
#######################################################################################################################  
  def default_values
    #self.clientcontact ||= false   #TODO: assign default values from migration 
  end
  
  
  def company_name
    company.name if company.present? 
  end

  
  def company_name=(name)
    self.company = Company.find_or_create_by_name(name) unless name.blank?
  end
  
  
  def make_new_company_current
   if self.current
     user_companies = self.user.user_companies.where(:current => true)
     user_companies.each do |user_com|
       user_com.update_attributes(:current => false)
     end
   end
  end

end
