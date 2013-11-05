Tfp::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations", :sessions => "sessions", :passwords => "passwords", :confirmations => "confirmations" }, :path_names => { :sign_in => 'login'}
  # devise_for :users, :controllers => { :sessions => 'users/sessions' }

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  match 'home'  => 'static_pages#home_page',   :as => 'home',  :via => :get
  match 'contact_us'  => 'static_pages#contact_us',   :as => 'contact_us',  :via => :get
  match 'about_us'  => 'static_pages#about_us',   :as => 'about_us',  :via => :get
  match 'client_info'  => 'static_pages#client_info',   :as => 'client_info',  :via => :get
  match 'signup_confirmation'  => 'static_pages#signup_confirmation',   :as => 'signup_confirmation',  :via => :get
  match 'static_pages/user_details_mailer'  => 'static_pages#client_info',   :as => 'user_details_mailer',  :via => :put

  # match '/users/auth/facebook' => 'omniauth_callbacks#passthru'/
  #
  # match '/users/auth/facebook' => 'services#create'
  # match '/users/auth/linkedin' => 'services#create'
  # match '/users/auth/google' => 'services#create'
  # match '/users/auth/google/callback' => 'services#create'
  # match '/users/auth/linkedin/callback' => 'services#create'

  # match 'client/dashboard'  => 'clients#dashboard',  :as => 'client',  :via => :get

  get "user_profiles/dashboard", :as => :user_dashboard
  get "user_profiles/personal_details"
  get "user_profiles/employment_details"

  get "user_profiles/upload_cv"
  get "user_profiles/online_test"
  get "user_profiles/qualifications"
  get "user_profiles/skills"
  get "user_profiles/work_eligibility"
  get "user_profiles/summary"
  get "user_profiles/online_test_link_click"

  post "user_profiles/personal_details"
  post "user_profiles/employment_details"

  match "/user_profiles/upload_cv" => "user_profiles#upload_cv"
  match "/user_profiles/online_test" => "user_profiles#online_test"
  match "/user_profiles/qualifications" => "user_profiles#qualifications"
  match "/user_profiles/skills" => "user_profiles#skills"
  match "/user_profiles/work_eligibility" => "user_profiles#work_eligibility"
  match "/user_profiles/summary" => "user_profiles#summary"
  match "/user_profiles/online_test_link_click" => "user_profiles#online_test_link_click"

  post "user_profiles/online_test"
  post "user_profiles/qualifications"
  post "user_profiles/skills"
  post "user_profiles/work_eligibility"
  post "user_profiles/summary"
  post "user_profiles/online_test_link_click"

  get "/user_profiles/remove_qualification/:qualiID" => "user_profiles#remove_qualification"
  get "/user_profiles/remove_it_skill/:item_id" => "user_profiles#remove_it_skill"
  get "/user_profiles/remove_other_skill/:item_id" => "user_profiles#remove_other_skill"
  get "/user_profiles/remove_language/:item_id" => "user_profiles#remove_language"
  
  get "exams/dashboard" => "exams#dashboard"
  
  match '/staffs/my_details' => 'staffs#my_details'
  match '/staffs/manage_users' => 'staffs#manage_users'
  match '/staffs/manage_roles' => 'staffs#manage_roles'
  match '/staffs/system_config' => 'staffs#system_config'
  match '/staffs/dashboard' => 'staffs#dashboard'
  
  match '/staffs/save_my_details/:u_id' => 'staffs#save_my_details'
  match '/staffs/edit_user/:u_id' => 'staffs#edit_user'

  match '/staffs/set_user_status/:u_id/:status' => 'staffs#set_user_status'
  match '/staffs/update_system_setting/:s_id' => 'staffs#update_system_setting'

  match '/companies/set_tfp_contact' => 'companies#set_tfp_contact'
  match '/companies/update_company_whitelabeling_info' => 'companies#update_company_whitelabeling_info'

  match "/questions/question_profile" => "questions#question_profile"
  # match "/questions/online_test" => "user_profiles#online_test"
  # match "/questions/qualifications" => "user_profiles#qualifications"
  # match "/questions/skills" => "user_profiles#skills"
  # match "/questions/work_eligibility" => "user_profiles#work_eligibility"
  # match "/questions/summary" => "user_profiles#summary"

  match "questions/remove_files/:id" => "questions#remove_files"
  match "questions/select_question_part/:question_part_type" => "questions#select_question_part"

  match "tests/remove_question/:id" => "tests#remove_question"
  match "tests/add_question/:id" => "tests#add_question"

  match "exams/remove_test/:id" => "exams#remove_test"
  match "exams/add_test/:id" => "exams#add_test"

#====================================== contact routes ==================================================
  
  match "/contacts/update_contact_profile" => "contacts#update_contact_profile"
  match "/contacts/render_contact_profile_section" => "contacts#render_contact_profile_section"
  match "/contacts/create_contact" => "contacts#create_contact"
  match "/contacts/create_contact_log" => "contacts#create_contact_log"
  match "/contacts/add_campaign" => "contacts#add_campaign"
  match "/contacts/add_interview" => "contacts#add_interview"
  match "/contacts/save_contact_traits" => "contacts#save_contact_traits"
  match "/contacts/update_contact" => "contacts#update_contact"
   
  resources :staffs do
    match 'dashboard'
    match 'settings'
    post 'create_user'
  end

  # resources :clients do
  # match 'dashboard', :as => 'home',  :via => :get
  # match 'settings'
  # post 'create_user'
  # end
  resources :staffs
  resources :companies
  resources :campaigns  
  resources :exams
  
  resources :questions
  
  resources :tests
  
  resources :contacts  
  # resources :users do
  # resource :user_profiles do
  # get "add_qualification"
  # get "add_it_skill"
  # get "add_other_skill"
  # get "add_language"
  # get "upload_profile_photo"
  # get "add_user_company"
  # get "complete_profile"
  # get "dowload_cv"
  # end
  # end

  resource :user_profiles do
    get :autocomplete_qualification_type_name, :on => :collection
    get :autocomplete_qualification_location_name, :on => :collection
    get :autocomplete_qualification_subject_name, :on => :collection
    get :autocomplete_itskill_name, :on => :collection
    get :autocomplete_company_name, :on => :collection
  end

  resource :user_profiles

  resource :database_managements do
    get :autocomplete_company_name, :on => :collection
    get :autocomplete_qualification_type_name, :on => :collection
    get :autocomplete_qualification_location_name, :on => :collection
    get :autocomplete_qualification_subject_name, :on => :collection
    get :autocomplete_qualification_grade_name, :on => :collection
    get :autocomplete_itskill_name, :on => :collection
    get :autocomplete_language_name, :on => :collection
  end

  get "database_managements/traits"
  get "database_managements/create_trait"
  match "database_managements/create_trait" => "database_managements#create_trait"
  get "database_managements/edit_trait_type/:trait_id" =>"database_managements#edit_trait_type"
  get "database_managements/update_trait"
  match "/database_managements/update_trait" => "database_managements#update_trait"
  get "database_managements/remove_trait/:traitID" => "database_managements#remove_trait"
  
  get "database_managements/question_categories"
  get "database_managements/create_question_category"
  match "database_managements/create_question_category" => "database_managements#create_question_category"
  get "database_managements/edit_question_category/:question_category_id" =>"database_managements#edit_question_category"
  get "database_managements/update_question_category"
  match "/database_managements/update_question_category" => "database_managements#update_question_category"
  get "database_managements/remove_question_category/:categoryID" => "database_managements#remove_question_category"
  
  get "database_managements/companies"
  get "database_managements/change_company_status_to_active/:id" => "database_managements#change_company_status_to_active"
  get "database_managements/change_company_status_to_deleted/:company_selected/:company_selected_id" => "database_managements#change_company_status_to_deleted"
    
  get "database_managements/qualification_types"
  #get "database_managements/create_qualification_type"
  match "database_managements/create_qualification_type" => "database_managements#create_qualification_type"
  get "database_managements/change_qualification_type_status_to_active/:id" => "database_managements#change_qualification_type_status_to_active"
  get "database_managements/change_qualification_type_status_to_deleted/:qualification_type_selected/:qualification_type_selected_id" => "database_managements#change_qualification_type_status_to_deleted"

  get "database_managements/qualification_locations"
  #get "database_managements/create_qualification_location"
  match "database_managements/create_qualification_location" => "database_managements#create_qualification_location"
  get "database_managements/change_location_status_to_active/:id" => "database_managements#change_location_status_to_active"
  get "database_managements/change_location_status_to_deleted/:qualification_location_selected/:qualification_location_selected_id" => "database_managements#change_location_status_to_deleted"

  get "database_managements/qualification_subjects"
  match "database_managements/create_qualification_subject" => "database_managements#create_qualification_subject"
  #get "database_managements/change_subject_status_to_active"
  get "database_managements/change_subject_status_to_active/:id" => "database_managements#change_subject_status_to_active"
  get "database_managements/change_subject_status_to_deleted/:qualification_subject_selected/:qualification_subject_selected_id" => "database_managements#change_subject_status_to_deleted"

  get "database_managements/qualification_grades"
  match "database_managements/create_qualification_grade" => "database_managements#create_qualification_grade"
  #get "database_managements/change_grade_status_to_active"
  get "database_managements/change_grade_status_to_active/:id" => "database_managements#change_grade_status_to_active"
  get "database_managements/change_grade_status_to_deleted/:qualification_grade_selected/:qualification_grade_selected_id" => "database_managements#change_grade_status_to_deleted"

  get "database_managements/itskills"
  match "database_managements/create_itskill" => "database_managements#create_itskill"
  #get "database_managements/change_itskill_status_to_active"
  get "database_managements/change_itskill_status_to_active/:id" => "database_managements#change_itskill_status_to_active"
  get "database_managements/change_itskill_status_to_deleted/:itskill_selected/:itskill_selected_id" => "database_managements#change_itskill_status_to_deleted"

  get "database_managements/languages"
  match "database_managements/create_language" => "database_managements#create_language"
  #get "database_managements/change_language_status_to_active"
  get "database_managements/change_language_status_to_active/:id" => "database_managements#change_language_status_to_active"
  get "database_managements/change_language_status_to_deleted/:language_selected/:language_selected_id" => "database_managements#change_language_status_to_deleted"

  resources :database_managements

  match '/client/summary' => 'clients#summary', :as => 'client_summary'
  match '/client/dashboard' => 'clients#dashboard', :as => 'client_dashboard'
  match '/client/profile' => 'clients#profile', :as => 'client_profile'
  match '/client/company_details' => 'clients#company_details', :as => 'client_company_details'
  match '/client/campaigns' => 'clients#campaigns', :as => 'client_campaigns'
  match '/client/new_campaign' => 'clients#new_campaign', :as => 'client_new_campaign'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  authenticated :user do
    root :to => 'static_pages#redirect_authenticated_user'
  end
  root :to => 'static_pages#home_page'

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
match ':controller(/:action(/:id))(.:format)'

end
