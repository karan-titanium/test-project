# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'colorize'

puts "creating Roles..."

  Role.create(name: 'Super Admin')
  Role.create(name: 'Staff')
  Role.create(name: 'Role 1')
  Role.create(name: 'Role 2')
  Role.create(name: 'Role 3')

puts "completed........"


puts "creating Permission..."

  Permission.create(action: 'manage', subject_class:'all')

puts "completed........"


puts "creating system settings..."

  sys_cat_1 = SettingCategory.create(:name => "tooltips")
  sys_cat_4 = SettingCategory.create(:name => "error message")
  sys_cat_2 = SettingCategory.create(:name => "email")
  sys_cat_3 = SettingCategory.create(:name => "website content")

puts "completed........"



puts "creating system settings for website content..."

  SystemSetting.create(:name => 'timeout_in', :key =>'timeout_in', :value => '10', :description => 'description_timeout_in', :setting_type => SETTING_TYPE_INT, :editable => true, :setting_category_id => sys_cat_1.id)
  SystemSetting.create(:name => 'exam_explanation_text', :key =>'exam_explanation_text', :value => 'exam_explanation_text', :description => 'exam_explanation_text', :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_1.id)
  SystemSetting.create(:name => 'exam_warning_text', :key =>'exam_warning_text', :value => 'exam_warning_text', :description => 'exam_warning_text', :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_1.id)
  SystemSetting.create(:name => 'qualification_text', :key =>'qualification_text', :value => 'qualification_text', :description => 'qualification_text', :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_2.id)
  SystemSetting.create(:name => 'upload_cv_text', :key =>'upload_cv_text', :value => 'upload_cv_text', :description => 'upload_cv_text', :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_2.id)
  SystemSetting.create(:name => 'skills_text', :key =>'skills_text', :value => 'skills_text', :description => 'skills_text', :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_2.id)
  SystemSetting.create(:name => 'work_eligability_text', :key =>'work_eligability_text', :value => 'work_eligability_text', :description => 'work_eligability_text', :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_2.id)
  # SystemSetting.create(:name => 'contact_us_phone', :key =>'contact_us_phone', :value => 'contact_us_phone', :description => 'contact_us_phone', :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_3.id)
  # SystemSetting.create(:name => 'contact_us_email', :key =>'contact_us_email', :value => '168570@gmail.com', :description => 'contact_us_email', :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_2.id)
  SystemSetting.create(:name => 'from_email', :key =>'from_email', :value => 'tfp@gmail.com', :description => 'contact_us_email', :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_2.id)
  # SystemSetting.create(:name => 'contact_us_address_line1', :key =>'contact_us_address_line1', :value => '123 East St, London,', :description => 'contact_us_address_line1', :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_3.id)
  # SystemSetting.create(:name => 'contact_us_address_line2', :key =>'contact_us_address_line2', :value => 'W3 5BQ View Demo', :description => 'contact_us_address_line2', :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_3.id)
  
  # SystemSetting.create(:name => 'about_us', :key =>'about_us', :value => 'TopFivePercent (TFP) is a web based recruitment portal system, developed by UWP Group. The aim of this portal is to provide TFP staff with a powerful system for collecting and organising the details of candidates, testing their attributes online and in person, and matching them to job requirements.</br></br> TFP provide the most eligiable candidates to the clients, for job positions they wish to fill.', :description => 'about_us', :setting_type => SETTING_TYPE_HTML, :editable => true, :setting_category_id => sys_cat_3.id)
  # SystemSetting.create(:name => 'home_page', :key =>'home_page', :value => 'Search doesnt end with numerous options but with that one option which fits your search.We at TFP do not focus on the numbers but on the quality delivered. TFP is the answers for your search if you are looking for people or company.', :description => 'home_page', :setting_type => SETTING_TYPE_HTML, :editable => true, :setting_category_id => sys_cat_3.id)
#   
  # SystemSetting.create(:name => 'confirmation_text', :key =>'confirmation_text', :value => 'Thank you for creating an account with TFP. Please check your email to confirm your registration and to access your user account.', :description => 'confirmation_text', :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_1.id)
 
  SystemSetting.create(:key => "s1", :name => "Admin Email", :description => "The email address to send system alerts to", :value => "kiran@titanium.net", :setting_type => SETTING_TYPE_EMAIL, :editable => true, :setting_category_id => sys_cat_3.id)
  SystemSetting.create(:key => "s2", :name => "Welcome Email text", :description => "When a new candidate signs up, send them an email with this content", :value => "Welcome to TFP", :setting_type => SETTING_TYPE_LONGTEXT, :editable => true, :setting_category_id => sys_cat_3.id)

  
puts "completed........"


puts "creating staff users..."

  staff_1 = User.new(:first_name => "Kiran", :last_name => "Shirapure", :email => "kiran@sancustechnologies.com", :password => "password123", :password_confirmation => "password123", :user_type => USER_TYPE_STAFF, :status => USER_STATUS_ACTIVE)   #, :role_id => Role.find_by_name('Super Admin').id)
  staff_1.skip_confirmation!
  staff_1.save
   
  staff_2 = User.new(:first_name => "Rugved", :last_name => "Shirapure", :email => "rugved@sh.com", :password => "password123", :password_confirmation => "password123", :user_type => USER_TYPE_STAFF, :status => USER_STATUS_ACTIVE)    #, :role_id => Role.find_by_name('Staff').id)
  staff_2.skip_confirmation!
  staff_2.save
  
  staff_3 = User.new(:first_name => "Dipta", :last_name => "dipta", :email => "dipta@topfivepercent.co.uk", :password => "dipta123", :password_confirmation => "dipta123", :user_type => USER_TYPE_STAFF, :status => USER_STATUS_ACTIVE)    #, :role_id => Role.find_by_name('Staff').id)
  staff_3.skip_confirmation!
  staff_3.save

  
puts "completed........"


puts "creating candidate users..."

  candidate_1 = User.new(:first_name => "Satish", :last_name => "Aher", :email => "satish@titaniuminteractive.net", :password => "password", :password_confirmation => "password", :user_type => USER_TYPE_CONTACT, :status => USER_STATUS_ACTIVE)
  candidate_1.skip_confirmation!
  candidate_1.save

puts "completed........"

puts "creating Client users..."

  client_1 = User.new(:first_name => "Client", :last_name => "User", :email => "client@gmail.com", :password => "password", :password_confirmation => "password", :user_type => USER_TYPE_CONTACT, :status => USER_STATUS_ACTIVE)
  client_1.skip_confirmation!
  client_1.save
  company = Company.create(:name => 'Sancus Technologies pvt ltd', :status => 'active')
  company.save
  client_1.companies << company
  if client_1.save
  uc = client_1.user_companies.last
  uc.clientcontact = true
  uc.save
  end
  
puts "completed........"



puts "creating email templates"

  EmailTemplate.create(:name => 'contact_us', :subject => 'Thank you for contacting TFP', :content_html => "<p>Dear Member,<br /><br />Thank you for your email.<br />We have received your message and will reply shortly.<br />Further information about your query is included below.<br /><br />username: %{name}<br />email:&nbsp;%{email}<br />phone no. :&nbsp;%{phone}<br />user message:&nbsp;%{message}<br /><br />We hope that you continue to enjoy Toluna!<br /><br />Thank you for contacting us.<br />The TFP Support Team</p>", :content_plain => "username: %{name}" )

puts "completed........"

puts "creating tooltips for Signup Login Contact_us and its Header ..."
  
puts "completed........"

puts "creating system setting for error messages Login..."


# model messages
  # SystemSetting.create(:key => "e_user_first_name_blank_message", :name => "user_first_name_blank_message", :description => "this is error msg for first name blank", :value => "first name is blank", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
  # SystemSetting.create(:key => "e_user_last_name_blank_message", :name => "user_last_name_blank_message", :description => "this is error msg for last name blank", :value => "last names is blank", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
  # SystemSetting.create(:key => "e_user_first_name_too_long_message", :name => "e_user_first_name_too_long_message", :description => "this is error msg for first lenght >50", :value => "first name is too long max length 50", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
  # SystemSetting.create(:key => "e_user_last_name_too_long_message", :name => "user_last_name_blank_message", :description => "this is error msg for last name >50", :value => "last name is too long max length 50", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
#   
  # SystemSetting.create(:key => "contact_us_error_user_name", :name => "contact_us_error_user_name", :description => "this is first blank name msg", :value => "please enter your name", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
  # SystemSetting.create(:key => "contact_us_error_user_phone", :name => "contact_us_error_user_phone", :description => "this is message for phone no format incorrect", :value => "mobile no. format is not correct", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
  # SystemSetting.create(:key => "contact_us_error_email_phone", :name => "contact_us_error_user_name", :description => "email & phone no. missing", :value => "please enter atleast one contact email or phone no.", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
  # SystemSetting.create(:key => "contact_us_error_user_email", :name => "contact_us_error_user_name", :description => "this is first blank name msg", :value => "email format is not correct", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)
  # SystemSetting.create(:key => "contact_us_error_user_message", :name => "contact_us_error_user_name", :description => "this is first blank name msg", :value => "please enter some message", :setting_type => SETTING_TYPE_TEXT, :editable => true, :setting_category_id => sys_cat_4.id)


puts "completed........"

  candidate_1 = User.find_by_email('satish@titaniuminteractive.net')
  
puts "Create Company start"
  c1 = Company.create(:name => 'Titanium Interactive pvt ltd', :status => 'active')
  c2 = Company.create(:name => 'Sancus Technologies pvt ltd', :status => 'active')
puts "End Company start"

puts "Create Qualification Type start"
  q1 = QualificationType.create(:name =>"GCSE Level", :status => 'active')
puts "End Company start"

puts "Create Qualification Subject start"
  s1 = QualificationSubject.create(:name =>"Science", :status => 'active')
  s2 = QualificationSubject.create(:name =>"Design and Technology ICT", :status => 'active')
  s3 = QualificationSubject.create(:name =>"Geography", :status => 'active')
  s4 = QualificationSubject.create(:name =>"Religious Education", :status => 'active')
  s5 = QualificationSubject.create(:name =>"Physical Education", :status => 'active')
  s6 = QualificationSubject.create(:name =>"Art and Design", :status => 'active')
puts "End Qualification Subject"

puts "Create Qualification Location start"
  ql1 = QualificationLocation.create(:name =>"Churchfield Junior School", :status => 'active')
  ql2 = QualificationLocation.create(:name =>"St John s Primary School", :status => 'active')
puts "End location/School"

puts "Create It Skills start"
  it1 = Itskill.create(:name =>"Microsoft Office Suite 2000", :status => 'active')
  it2 = Itskill.create(:name =>" Microsoft Powerpoint", :status => 'active')
  it3 = Itskill.create(:name =>"Microsoft Excel", :status => 'active')
puts "End It skill start"

puts "Create Qualification Grade start"
  qg1 = QualificationGrade.create(:name =>"A", :status => 'active', :order => 1, :qualification_type_id => 1)
  qg2 = QualificationGrade.create(:name =>"B", :status => 'active', :order => 2, :qualification_type_id => 1)
  qg3 = QualificationGrade.create(:name =>"C", :status => 'active', :order => 3, :qualification_type_id => 1)
  qg4 = QualificationGrade.create(:name =>"D", :status => 'active', :order => 4, :qualification_type_id => 1)
  qg5 = QualificationGrade.create(:name =>"E", :status => 'active', :order => 5, :qualification_type_id => 1)
puts "End Qualification skill start"

puts "Create Language start"
  l1 = Language.create(:name =>"Italian", :status => 'active')
  l2 = Language.create(:name =>"Tamil", :status => 'active')
  l3 = Language.create(:name =>"French", :status => 'active')
  l4 = Language.create(:name =>"German", :status => 'active')
  l5 = Language.create(:name =>"English", :status => 'active')
  l6 = Language.create(:name =>"Hindi", :status => 'active')
puts "End Language start"


puts "Create User Companies"
  candidate_1 = User.find_by_email('satish@titaniuminteractive.net')
  
  UserCompany.create(:user_id => candidate_1.id, :company_id => c1.id, :current => true, :from => '2013-3-11'.to_date, :untill => nil, :position => 'software developer')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c2.id, :current => false, :from => '2012-3-11'.to_date, :untill => '2012-7-11'.to_date, :position => 'software tester')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c1.id, :current => false, :from => '2012-1-11'.to_date, :untill => '2012-3-11'.to_date, :position => 'software developer')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c2.id, :current => false, :from => '2013-7-11'.to_date, :untill => '2013-9-11'.to_date, :position => 'software developer')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c1.id, :current => false, :from => '2011-3-11'.to_date, :untill => '2011-7-11'.to_date, :position => 'Team Lead')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c2.id, :current => false, :from => '2010-3-11'.to_date, :untill => '2010-7-11'.to_date, :position => 'Project manager')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c1.id, :current => false, :from => '2010-1-11'.to_date, :untill => '2010-5-11'.to_date, :position => 'software trainer')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c2.id, :current => false, :from => '2009-1-11'.to_date, :untill => '2009-2-11'.to_date, :position => 'software developer')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c1.id, :current => false, :from => '2009-3-11'.to_date, :untill => '2009-4-11'.to_date, :position => 'software tester')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c2.id, :current => false, :from => '2009-5-11'.to_date, :untill => '2009-7-11'.to_date, :position => 'software developer')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c1.id, :current => false, :from => '2008-3-11'.to_date, :untill => '2008-7-11'.to_date, :position => 'software developer')
  UserCompany.create(:user_id => candidate_1.id, :company_id => c2.id, :current => false, :from => '2013-7-11'.to_date, :untill => '2013-12-11'.to_date, :position => 'software tester')
puts "End User Companies"


puts "Create User Qualifications"
  candidate_1 = User.find_by_email('satish@titaniuminteractive.net')
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql1.id, :qualification_subject_id => s1.id, :qualification_grade_id => qg1.id, :year => 2011)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql2.id, :qualification_subject_id => s2.id, :qualification_grade_id => qg2.id, :year => 2012)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql1.id, :qualification_subject_id => s3.id, :qualification_grade_id => qg3.id, :year => 2013)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql2.id, :qualification_subject_id => s4.id, :qualification_grade_id => qg4.id, :year => 2010)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql1.id, :qualification_subject_id => s5.id, :qualification_grade_id => qg1.id, :year => 1234)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql2.id, :qualification_subject_id => s1.id, :qualification_grade_id => qg2.id, :year => 1234)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql1.id, :qualification_subject_id => s2.id, :qualification_grade_id => qg3.id, :year => 2009)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql2.id, :qualification_subject_id => s3.id, :qualification_grade_id => qg3.id, :year => 2008)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql1.id, :qualification_subject_id => s4.id, :qualification_grade_id => qg1.id, :year => 2007)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql2.id, :qualification_subject_id => s5.id, :qualification_grade_id => qg2.id, :year => 1234)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql1.id, :qualification_subject_id => s1.id, :qualification_grade_id => qg3.id, :year => 2006)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql2.id, :qualification_subject_id => s2.id, :qualification_grade_id => qg4.id, :year => 2008)
  UserQualification.create(:user_id => candidate_1.id, :qualification_type_id => q1.id, :qualification_location_id => ql1.id, :qualification_subject_id => s3.id, :qualification_grade_id => qg5.id, :year => 2005)
        
puts "End User Qualifications"


puts "Create User ItSkill"
  candidate_1 = User.find_by_email('satish@titaniuminteractive.net')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it1.id, :experience => 2, :level => 'basic')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it2.id, :experience => 5, :level => 'basic')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it3.id, :experience => 7, :level => 'intermediate')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it1.id, :experience => 2, :level => 'advanced')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it1.id, :experience => 2, :level => 'basic')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it2.id, :experience => 5, :level => 'advanced')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it3.id, :experience => 7, :level => 'intermediate')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it1.id, :experience => 2, :level => 'intermediate')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it1.id, :experience => 2, :level => 'basic')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it2.id, :experience => 5, :level => 'advanced')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it3.id, :experience => 7, :level => 'intermediate')
  UserItskill.create(:user_id => candidate_1.id, :itskill_id => it1.id, :experience => 2, :level => 'intermediate')
puts "End User ItSkill"

puts "Create User Other"
  candidate_1 = User.find_by_email('satish@titaniuminteractive.net')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 1 skill', :experience => 2, :level => 'basic')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 2 skill', :experience => 5, :level => 'basic')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 3 skill', :experience => 7, :level => 'intermediate')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 4 skill', :experience => 2, :level => 'advanced')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 5 skill', :experience => 2, :level => 'basic')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 6 skill', :experience => 5, :level => 'advanced')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 7 skill', :experience => 7, :level => 'intermediate')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 8 skill', :experience => 2, :level => 'intermediate')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 9 skill', :experience => 2, :level => 'basic')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 10 skill', :experience => 5, :level => 'advanced')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 11 skill', :experience => 7, :level => 'intermediate')
  UserOtherskill.create(:user_id => candidate_1.id, :skill => 'testing 12 skill', :experience => 2, :level => 'intermediate')
puts "End User otherSkill"

puts "Create User Languages"
  candidate_1 = User.find_by_email('satish@titaniuminteractive.net')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l1.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l2.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l3.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l4.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l1.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l2.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l3.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l4.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l2.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l3.id, :spoken => 'basic', :written => 'basic')
  UserLanguage.create(:user_id => candidate_1.id, :language_id => l4.id, :spoken => 'basic', :written => 'basic')
puts "End User Languages"

puts "Create Traits"
  trait_1 = Trait.create(status: 'public', name: 'Trait_1', description: 'TRAIT_basic')
  trait_2 = Trait.create(status: 'public', name: 'Trait_2', description: 'TRAIT_basic')
  trait_3 = Trait.create(status: 'public', name: 'Trait_3', description: 'TRAIT_basic')
  trait_4 = Trait.create(status: 'internal', name: 'Trait_4', description: 'TRAIT_basic')
puts "End User Languages"

puts "creating usertraits for candidate_1 users..."
  candidate_1 = User.find_by_email('satish@titaniuminteractive.net')
  ut = UserTrait.create(:trait_id => trait_1.id, :user_id => candidate_1.id, :score => 50)
  binding.pry
  UserTrait.create(:trait_id => trait_2.id, :user_id => candidate_1.id, :score => 60)
  UserTrait.create(:trait_id => trait_3.id, :user_id => candidate_1.id, :score => 70)
  UserTrait.create(:trait_id => trait_4.id, :user_id => candidate_1.id, :score => 40)

puts "completed........"


puts "Email Template for incomplate profile reminder"

EmailTemplate.create(:content_html => '<div>Dear %{name},</div><div>&nbsp;</div><div>There are few profile questions that need to be completed, in order for better job search.</div><div>&nbsp;</div><div>Your chance of &nbsp;getting the right job will be improved by updating this information.</div><div>&nbsp;</div><div>Thank you</div><div>The TFP Support Team&quot;</div>', :subject => 'Update profile missing details to improve your chances of recruitment', :name => 'Incomplete profile')

puts "End of Email Template for incomplate profile reminder"


#READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE
# ****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************READING XLSX FILE*****************
puts "*****************************************Creating SystemSettings by using xslx (public/test7.xslx) ********************"

file = ("public/SystemSettings.xlsx")
s = Roo::Excelx.new(file)
# s = Roo::Google.new("myspreadsheetkey_at_google")
s.sheets.each do |sheet|
  if sheet.upcase == 'TOOL_TIP'
    puts "\nCreating TOOL_TIPS....................................."
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        # no = s.cell(trav_row, trav_col).downcase
        key  = s.cell(trav_row, trav_col + 1 )
        name = s.cell(trav_row, trav_col + 2 )
        description  = s.cell(trav_row, trav_col + 3 )
        value  = s.cell(trav_row, trav_col + 4 )
        setting_type  = s.cell(trav_row, trav_col + 5 )
        editable  = s.cell(trav_row, trav_col + 6 )
        if editable
          editable.downcase == 'true' ? editable=true : editable=false 
        else 
          editable = false 
        end
        setting = SystemSetting.new(:name => name, :key => key, :value => value, :description => description ,:setting_type => SETTING_TYPE_LONGTEXT, :editable => editable, :setting_category_id => sys_cat_1.id)
        puts ("\t fails in TOOL_TIP line "+trav_row.to_s+"  "+setting.errors.messages.to_s).red if !setting.valid?
        setting.save
        trav_row = trav_row + 1
      end
    end
    puts "TOOL_TIPS Complited"
  end
  if sheet.upcase == 'ERROR'
    
    puts "\nCreating ERRORS..................................."
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
      
        key  = s.cell(trav_row, trav_col + 1 )
        name = s.cell(trav_row, trav_col + 2 )
        description  = s.cell(trav_row, trav_col + 3 )
        value  = s.cell(trav_row, trav_col + 4 )
        setting_type  = s.cell(trav_row, trav_col + 5 )
        editable  = s.cell(trav_row, trav_col + 6 )
        if editable
          editable.downcase == 'true' ? editable=true : editable=false 
        else 
          editable = false 
        end
        
        setting = SystemSetting.new(:name => name, :key => key, :value => value, :description => description ,:setting_type => SETTING_TYPE_LONGTEXT, :editable => editable, :setting_category_id => sys_cat_1.id)
        puts ("\t fails in ERROR line "+trav_row.to_s+"  "+setting.errors.messages.to_s).red if !setting.valid?
        setting.save
        trav_row = trav_row + 1
      end
    end
    puts "ERROR_MESSAGES Complited"
  end
  if sheet.upcase == 'HINT_TEXT'
    puts "\nCreating HINT_TEXT....................................."
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        key  = s.cell(trav_row, trav_col + 1 )
        name = s.cell(trav_row, trav_col + 2 )
        description  = s.cell(trav_row, trav_col + 3 )
        value  = s.cell(trav_row, trav_col + 4 )
        setting_type  = s.cell(trav_row, trav_col + 5 )
        editable  = s.cell(trav_row, trav_col + 6 )
        if editable
          editable.downcase == 'true' ? editable=true : editable=false 
        else 
          editable = false 
        end
        setting = SystemSetting.new(:name => name, :key => key, :value => value, :description => description ,:setting_type => SETTING_TYPE_LONGTEXT, :editable => editable, :setting_category_id => sys_cat_1.id)
        puts ("\t fails in EMAIL line "+trav_row.to_s+"  "+setting.errors.messages.to_s).red if !setting.valid? 
        setting.save
        trav_row = trav_row + 1
      end
    end
    puts "EMAIL Complited"
  end
  if sheet.upcase == 'CONTENT'
    puts "\nCreating CONTENTS................................."
    begin
      s.default_sheet = sheet
      fr = s.first_row.to_i
      trav_col = fc = s.first_column.to_i
      lr = s.last_row.to_i
      lc = s.last_column.to_i
      trav_row = fr + 1
      while trav_row <= lr do
        
        key  = s.cell(trav_row, trav_col + 1 )
        name = s.cell(trav_row, trav_col + 2 )
        description  = s.cell(trav_row, trav_col + 3 )
        value  = s.cell(trav_row, trav_col + 4 )
        setting_type  = s.cell(trav_row, trav_col + 5 )
        editable  = s.cell(trav_row, trav_col + 6 )
        if editable
          editable.downcase == 'true' ? editable=true : editable=false 
        else 
          editable = false 
        end

        setting = SystemSetting.new(:name => name, :key => key, :value => value, :description => description ,:setting_type => SETTING_TYPE_LONGTEXT, :editable => editable, :setting_category_id => sys_cat_1.id)
        puts ("\t fails in CONTENT line "+trav_row.to_s+"  "+setting.errors.messages.to_s).red if !setting.valid?
        setting.save
        trav_row = trav_row + 1
      end
    end
    puts "CONTENTS Complited\n\n"
  end
end #do |sheet|
puts "*****************************************xslx (public/test7.xslx) reading complited ********************"

puts "*****************************************Creating YAML file for system settings from system setting table ********************"

File.open('config/system_settings.yml','w') do |s|

      s.puts "defaults: &defaults"
      s.puts "\n"
      s.puts "\n"
      SystemSetting.all.each do |ss|
        
      s.puts   "  "+ss.key+": \""+"<%= (system_setting = SystemSetting.find_by_key('"+ss.key+"')) ? system_setting.value : '*' %>\""
        # s.puts ss.key+": '"+ss.value+"'"
        
      end
      s.puts "\n"
      s.puts "development:"
      s.puts "  <<: *defaults"
      s.puts "\n"
      s.puts "test:"
      s.puts "  <<: *defaults"
      s.puts "\n"
      s.puts "production:"
      s.puts "  <<: *defaults"
    end

puts "*****************************************YAML(system_settings.yml) file creates  ********************"
  



