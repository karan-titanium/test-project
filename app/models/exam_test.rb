class ExamTest < ActiveRecord::Base
  
  attr_accessible :exam_id, :tfp_test_id, :order
  

  #--- Relations ---#
  belongs_to :exam
  belongs_to :tfp_test
    

  #--- Validations ---#
  validates :exam_id, :presence => true
  validates :tfp_test_id, :presence => true
  # validates :order, :presence => true
  
end
