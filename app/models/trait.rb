class Trait < ActiveRecord::Base
  
  attr_accessible :status, :name, :description
  
  #--- Relations ---#
  has_many :campaign_traits
  has_many :campaigns, :through => :campaign_traits
  
  has_many :user_traits
  has_many :users, :through => :user_traits 
  
  has_many :question_categories
  # belongs_to :question_category
  
  #============================================ validates============================================================================
  validates :name, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 50, :message => Settings.e_fieldlength_50 }
  validates :status, :presence => { :message => Settings.e_field_mandatory }, :inclusion => { :in => TRAIT_STATUS_LIST.map{|k,v| k}, :case_sensitive => false }
  validates :description, :presence => { :message => Settings.e_field_mandatory }, :length => {:maximum => 250, :message => Settings.e_fieldlength_250 }
  
  
  

end
