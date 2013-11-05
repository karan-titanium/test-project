class CampaignExam < ActiveRecord::Base
  
  attr_accessible :campaign_id, :exam_id, :stage
  
  #--- Relations ---#
  belongs_to :campaign
  belongs_to :exam

  
  #--- Validations ---#
  validates :campaign_id, :presence => true
  validates :exam_id, :presence => true
  validates :stage, :presence => true

      
end
