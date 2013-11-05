class QuestionOption < ActiveRecord::Base
  
  attr_accessible :question_part_id, :order, :content, :points
  

  #--- Relations ---#
  belongs_to :question_part
  
# after_save :hang
  # def hang
    # puts"in Question options"
    # binding.pry
  # end
  #--- Validations ---#
  # validates :question_part_id, :presence => true
  # validates :order, :presence => true
  validates :content, :presence => true
  validates :points, :presence => true
  
end
