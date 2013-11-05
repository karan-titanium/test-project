class QuestionPart < ActiveRecord::Base
  
  attr_accessible :question_id, :order, :content, :question_part_type, :question_options_attributes

  #--- Relations ---#
  belongs_to :question

  has_many :question_options, :dependent => :destroy
  accepts_nested_attributes_for :question_options, :allow_destroy => true, :reject_if => :all_blank, :update_only => true
  
  
  
  #--- Validations ---#
    
    # puts "validating"
    # validates :question_id, :presence => true
    # validates :order, :presence => true
    # validates :content, :presence => true
    # validates :question_part_type, :presence => true
  
end
