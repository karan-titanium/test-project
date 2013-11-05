# require 'file_size_validator'
class CdnFile < ActiveRecord::Base
  attr_accessible :cf_filename, :file_type, :date, :filename, :ext, :mimetype, :size, :uploaded_by, :crop_x, :crop_y, :crop_w, :crop_h, :question_file_attributes, :remove_cdn_file  #, :user_id

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :is_thumbnable

  mount_uploader :cf_filename, FileUploader



#--- Relations ---#  
  has_one :user_file
  has_one :user, :through => :user_file
  has_one :user_profile, :foreign_key => :photo
  has_one :company
  
  has_many :contact_attachments
  has_many :contact_logs, :through => :contact_attachments 
  
  has_one :question_file
  has_one :question, :through => :question_file
  accepts_nested_attributes_for :question_file, :allow_destroy => true
  
  

#--- Validations ---#
  # validates :cf_filename, :presence => true  #Do not uncomment this
  # validates_size_of :cf_filename, maximum: 10.megabytes, message: "should be less than 10MB"
  # validates :cf_filename, :presence => true
   # validates :cf_filename, 
    # :presence => true, 
    # :file_size => { 
      # :maximum => 10.megabytes.to_i 
    # } 



#--- Callback ---#
  before_save :validates_size, :update_cdn_file_attributes
  after_update :crop_image
  
  
  

#--- Actions ---#
  def crop_image
    cf_filename.recreate_versions! if crop_x.present?
  end
  
  private
  
  def update_cdn_file_attributes
    if cf_filename.present? && cf_filename_changed?
      self.filename = cf_filename.file.filename
      self.ext = cf_filename.file.extension
      self.mimetype = cf_filename.file.content_type
      self.size = cf_filename.file.size
    end
  end
  
  def validates_size
    flag = true
    if cf_filename.present? && cf_filename_changed? && self.size.present? 
      if self.file_type == FILE_TYPE_IMAGE
         flag = false if cf_filename.file > 10.megabytes
      elsif self.file_type == FILE_TYPE_CV
         flag = false if cf_filename.file > 20.megabytes
      end  
    end
    errors.add(:filename, "size error") if !flag
  end
end
