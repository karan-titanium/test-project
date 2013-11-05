class UserExam < ActiveRecord::Base
  
  attr_accessible :user_id, :exam_id, :status, :date_start, :date_end
  
  #--- Relations ---#
  belongs_to :user
  belongs_to :exam

  
  #--- Validations ---#
  validates :user_id, :presence => true
  validates :exam_id, :presence => true
  validates :status, :presence => true
  
end
