class Interview < ActiveRecord::Base
  
  attr_accessible :date, :candidate, :interviewer, :campaign, :interview_type, :notes, :audiofile, :transcript
  
  #--- Relations ---#
  has_one :transcript_request
  
  belongs_to :user_candidate, :class_name => 'User', :foreign_key => 'candidate'
  belongs_to :user_interviewer, :class_name => 'User', :foreign_key => 'interviewer'
  #--- Validations ---#
  validates :date, :presence => true
  validates :candidate, :presence => true
  validates :interviewer, :presence => true
  validates :campaign, :presence => true
  validates :interview_type, :presence => true
  
end
