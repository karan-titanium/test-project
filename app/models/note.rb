class Note < ActiveRecord::Base
  
  attr_accessible :table, :table_col, :table_id, :user_id, :note
  

#--- Relations ---#

  belongs_to :user
    


#--- Validations ---#

  validates :table, :presence => {:message => Settings.e_field_mandatory}
  validates :table_col, :presence => {:message => Settings.e_field_mandatory}
  validates :table_id, :presence => {:message => Settings.e_field_mandatory}
  validates :user_id, :presence => {:message => Settings.e_field_mandatory}
  validates :note, :presence => {:message => Settings.e_field_mandatory}, :length => {:maximum => 500, :message => Settings.e_fieldlength_500}
  

  
#--- Actions ---#

#######################################################################################################################
# Objective: To return all the Notes created for a requested Company   
# Input: company
# Output: Returns all the Notes created for a requested Company
#######################################################################################################################  
  def self.notes_of_company(company)
    Note.where(:table => TABLE_COMPANIES, :table_id => company.id)
  end  

end
