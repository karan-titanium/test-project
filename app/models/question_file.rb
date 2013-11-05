class QuestionFile < ActiveRecord::Base
  attr_accessible :question_id, :cdn_file_id, :order, :title, :image

  # after_save :hang
  # def hang
    # puts"in Question file"
    # binding.pry
  # end
  #--- Relations ---#
  belongs_to :question
  belongs_to :cdn_file
#--- Validations ---#
# validates :question_id, :presence => true
# validates :order, :presence => true
# validates :title, :presence => true
end
