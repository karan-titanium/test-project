class QuestionCategory < ActiveRecord::Base
  
  attr_accessible :name, :trait_id , :status
  

  #--- Relations ---#
  has_many :questions
 
  belongs_to :trait
    
  #============================================ validates============================================================================
  validates :name, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50 }
  validates :status, :presence => { :message => Settings.e_field_mandatory }, :inclusion => { :in => QUESTION_CATEGORY_STATUS_LIST.map{|k,v| k}, :case_sensitive => false }
  
  
end
