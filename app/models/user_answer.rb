class UserAnswer < ActiveRecord::Base
  
  attr_accessible :sitting, :date, :test_id, :question_option_id, :answer, :points
  

  #--- Relations ---#

  
  #--- Validations ---#
  validates :sitting, :presence => true
  validates :date, :presence => true
  validates :test_id, :presence => true
  validates :question_option_id, :presence => true
  
end
