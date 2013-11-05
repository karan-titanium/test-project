class TfpTest < ActiveRecord::Base
  attr_accessible :name, :description, :status, :duration, :example
  
  #--- Relations ---#  
  
  has_many :exam_tests
  has_many :exam, :through => :exam_tests
  
  has_many :test_questions
  has_many :questions, :through => :test_questions
  
  
  #--- Validations ---#
  validates :name, :presence => true
  validates :description, :presence => true
  validates :status, :presence => true
  validates :duration, :presence => true
  
end
