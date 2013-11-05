class TestQuestion < ActiveRecord::Base
  
  attr_accessible :test_id, :question_id, :order
  

  #--- Relations ---#
  belongs_to :test
  belongs_to :question
    

  #--- Validations ---#
  validates :test_id, :presence => true
  validates :question_id, :presence => true
  validates :order, :presence => true
  
end
