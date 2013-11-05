class UserMailer < ActionMailer::Base
  #default from: "from@example.com" #TODO
  default from: SystemSetting.find_by_name('from_email').value.to_s
  
  
  # This action sends email to the tfp email which is mention in system setting with key contact_us_email
  # Email content is form field mentioned on contact us page,
  # this content is editable html which contains fix tags where we are replacing dynamic values,
  # tags are mentioned in %{ tag_name } format
  def send_contact_us_email( email_object )
    
    email_body = email_object[:content] % {name: email_object[:user][:name], email: email_object[:user][:email], phone: email_object[:user][:phone], message: email_object[:user][:message]}
    
    mail :body => email_body.html_safe, :to => email_object[:to], :subject => email_object[:subject], :from => SystemSetting.find_by_name('from_email').value, :content_type =>'text/html'
    
  end
  
  

  def welcome_email(to)     
    email_obj = EmailTemplate.find_by_name("contact_us")    #TODO: get value from related template
    mail :body => email_obj.content_html.html_safe, :to => to, :subject => email_obj.subject, :content_type =>'text/html'
  end

  def send_incomplete_profile_reminders( template, user )
    # :to => user.email #TODO
    email_body = template.content_html % {name: user.full_name}
    mail :body => email_body.html_safe, :to => user.email, :subject => template.subject, :from => SystemSetting.find_by_name('from_email').value, :content_type =>'text/html'
  end
end




