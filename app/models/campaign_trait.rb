class CampaignTrait < ActiveRecord::Base
  
  attr_accessible :campaign_id, :trait_id, :weight
  

  #--- Relations ---#
  belongs_to :campaign
  belongs_to :trait

  
  #--- Validations ---#
  # validates :campaign_id, :presence => true
  validates :trait_id, :presence => true
  validates :weight, :presence => true
  

end
