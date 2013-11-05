class UserTrait < ActiveRecord::Base
  
  attr_accessible :user_id, :trait_id, :score, :notes
  
  #--- Relations ---#
  belongs_to :user
  belongs_to :trait
  
  #--- Validations ---#
  validates :user_id, :presence => true
  validates :trait_id, :presence => true
  validates :score, :presence => true

end
