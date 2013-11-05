class Question < ActiveRecord::Base

  attr_accessible :question_category_id, :name, :description, :status, :content, :explanation, :difficulty,
                  :cdn_files_attributes, :question_parts_attributes

  #--- Relations ---#
  belongs_to :question_category

  has_many :test_questions
  has_many :tfp_tests, :through => :test_questions

  has_many :question_files, :dependent => :destroy
  # accepts_nested_attributes_for :question_files, :allow_destroy => true,:reject_if => :all_blank

  has_many :cdn_files, :through => :question_files, :dependent => :destroy
  accepts_nested_attributes_for :cdn_files, :allow_destroy => true, :reject_if => :all_blank

  has_many :question_parts,  :dependent => :destroy
  accepts_nested_attributes_for :question_parts, :allow_destroy => true, :reject_if => :all_blank
  #--- Validations ---#
  # validates :question_category_id, :presence => true
  validates :name, :presence => true
  validates :description, :presence => true
# validates :status, :presence => true
# validates :content, :presence => true
# validates :difficulty, :presence => true

end
