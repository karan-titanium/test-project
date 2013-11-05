class Service < ActiveRecord::Base
  
  
  attr_accessible :provider, :uemail, :uid, :uname, :user_id
  
  # Database Relation (Active model)
  belongs_to :user
  
end
