class UserCampaign < ActiveRecord::Base
  
  attr_accessible :user_id, :campaign_id, :date, :date_forwarded, :date_reviewed, :source_staff, :source_link,
                  :status, :phone_date, :phone_result, :phone_notes, :interview_date, :interview_result, :interview_notes
                  
#--- Relations ---#
  belongs_to :user
  belongs_to :campaign

  
#--- Validations ---#
  validates :user_id, :presence => true
  validates :campaign_id, :presence => {:message => 'cant be blank'}
  validates :date, :presence => true
  validates :status, :presence => true
  validates :phone_notes, :length => {:maximum => 256, :message => Settings.e_fieldlength_256}, :allow_blank => true
  validates :interview_notes, :length => {:maximum => 256, :message => Settings.e_fieldlength_256}, :allow_blank => true
  validates_inclusion_of :phone_result, :in => PHONE_RESULT_LIST, :allow_blank => true
  validates_inclusion_of :interview_result, :in => INTERVIEW_RESULT_LIST, :allow_blank => true                  
end
