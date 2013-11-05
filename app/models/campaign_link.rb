class CampaignLink < ActiveRecord::Base
  
  attr_accessible :campaign_id, :name, :description, :status, :url
  
  #--- Relations ---#
  belongs_to :campaign
  
  has_many :campaign_link_clicks

  
  #--- Validations ---#
  validates :campaign_id, :presence => true
  validates :name, :presence => true
  validates :status, :presence => true
  validates :url, :presence => true
  
end
