class StaticPagesController < ApplicationController
  #before_filter :load_and_authorize_resource
  #before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error
  
  layout "staticpage"
  
  # This filter indicates that user require authentication before executing action mentioned
  before_filter :authenticate_user!, :only => [:redirect_authenticated_user]
  
=begin

  Objective : This method redirects user after user is signed up
  
  Input : 
   
  Output : Redirects user after user is signed up
  
  Logic : This method check current user object and find type of user and redirect to its respective dashboard
          
=end  
  
  def redirect_authenticated_user
    if current_user.user_type == USER_TYPE_CONTACT
      if current_user.user_companies.empty?
        redirect_to user_dashboard_path 
      else
        current_user.user_companies.each do |user_company|
          if user_company.clientcontact?
            # binding.pry
            redirect_to client_dashboard_path and return
            # redirect_to client_path and return
            # render(:text => "logged in as client--------- client controller not added") and return #TODO : replace with client dashboard action
            break                  
          end
        end
        redirect_to user_dashboard_path
      end
    elsif current_user.user_type == USER_TYPE_STAFF
      redirect_to staff_dashboard_path(current_user.id)
    else
      render :text => "user_type not set for user"
    end
  end
  
  # Redirects user to Home page
  def home_page
    
  end
  # Redirects user to About Us page
  def about_us
    
  end
  # Redirects user to Contact Us page
  def contact_us
    
  end
  # Redirects user to Client Info
  def client_info
    
  end
  # Redirects user to signup_confirmation
  def signup_confirmation
    
  end
  
  # Objective: To shoot mail to TFP from Contact Us page
  # Input: Form parameters from Contact Us page
  # Output: shoot mail to TFP
  # Logic: Check whether one of the contact method is entered or not and shoots mail
  
  def user_details_mailer
    
    if ( (params[:user][:phone] == "" && params[:user][:email] == "") || params[:user][:message] == "" || params[:user][:name] == "")
      flash[:notice] = "something went wrong please try again"
      redirect_to contact_us_path
    else 
      template = EmailTemplate.find_by_name('contact_us')
      email_object = {:template => template.name,
                      :content => template.content_html,
                      :subject => template.subject,
                      :to => Settings.c_ContactTFP_Email,
                      :user => params[:user]
                      }
      UserMailer.send_contact_us_email(email_object).deliver
      flash[:notice] = t("tfp.information.user_details_mail")
      redirect_to contact_us_path
    end   
    
  end
 
end
    
