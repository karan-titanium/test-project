class Exam < ActiveRecord::Base
  
  attr_accessible :name, :description, :status, :generic, :intro, :rest
  

  #--- Relations ---#
  has_many :user_exams
  has_many :users, :through => :user_exams
  
  has_many :exam_tests
  has_many :tfp_tests, :through => :exam_tests
  
  
  #--- Validations ---#
  validates :name, :presence => true
  validates :description, :presence => true
  validates :status, :presence => true
  validates :intro, :presence => true
  validates :rest, :presence => true
  
  
end
