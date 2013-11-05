class TranscriptRequest < ActiveRecord::Base
  
  attr_accessible :user_id, :interview_id, :notified
  

  #--- Relations ---#
  belongs_to :user
  belongs_to :interview
  
  
  #--- Validations ---#
  validates :user_id, :presence => true
  validates :interview_id, :presence => true
  
end
