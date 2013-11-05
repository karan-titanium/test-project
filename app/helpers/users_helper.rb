module UsersHelper
  def work_eligibility_completely_filled? user
     user_profile = user.user_profile
     flag = true
     if "yes".casecmp(user_profile.passport.present? ? user_profile.passport : "") == 0
       
     elsif user_profile.passport == "no"
       if user_profile.eligableuk == "no"
         flag = user_profile.eligabledetails.present?
       end 
     else 
       flag = false  
     end   
     flag
  end
  def personal_details_completely_filled? user
    user_profile = user.user_profile
    personal_hash = {
            :first_name => user.first_name, 
            :last_name => user.last_name,
            :gender => user_profile.gender,
            :email => user.email,
            :mobil => user_profile.number_mob,
            :alter => user_profile.number_alt,
            :cont_meth =>  user_profile.contact_method,
            :cont_time =>  user_profile.contact_time,   
            :add_country =>  user_profile.address_country,
            :add_line1 => user_profile.address_line1, 
            :add_line1 => user_profile.address_line2, 
            :add_postcode => user_profile.address_postcode, 
            :add_town => user_profile.address_town  
          }
    personal_hash.values.all? {|x| !x.nil? && !x.blank? }
  end
  def employment_details_completely_filled? user
    user_profile = user.user_profile
    flag = true
    if user_profile.employed && user_profile.employed == "yes"
      flag = ( user.user_companies.where(:current => true).present? && user_profile.salary_current.present? && user_profile.salary_target.present? )
    else
      flag =  user_profile.salary_target.present?
    end 
    flag
  end
  
  def upload_cv_completely_filled? user
    user.user_files.where(:user_file_type => "cv").present?
  end
  def online_test_completely_filled? user
      return true    
  end
  def qualification_completely_filled? user
    user.user_qualifications.present?
  end
  def skills_completely_filled? user
    user.user_itskills.present? && user.user_otherskills.present? && user.user_languages.present?
  end
end
