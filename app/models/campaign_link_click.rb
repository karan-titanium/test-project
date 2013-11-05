class CampaignLinkClick < ActiveRecord::Base
  
  attr_accessible :campaign_link_id, :date, :referrer, :unique
  
  #--- Relations ---#
  belongs_to :campaign_link

  
  #--- Validations ---#
  validates :campaign_link_id, :presence => true
  validates :date, :presence => true
  validates :referrer, :presence => true
  validates :unique, :presence => true
  
end
