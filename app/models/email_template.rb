class EmailTemplate < ActiveRecord::Base
  attr_accessible :content_html, :content_plain, :name, :subject
end
