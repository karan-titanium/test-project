class ClientsController < ApplicationController
  # layout 'client'
  before_filter :authenticate_user! # Checks whether User is authenticated before processing each action
  before_filter :set_user # Makes necessry set of variables available to each action
  
  def dashboard
    # render :partial =>'dashboard'
  end
  
  def summary
    render :partial =>'summary'
  end
  
  def profile
    # render :partial =>'profile'
    @user.user_profile.contact_time = params[:contact_time] if !params[:contact_time].nil?
    render :partial =>  (@user.update_attributes(params[:user]) ? 'profile' : 'profile')
  end
  
  def transcript_requested
    # TranscriptRequest.create(:interview_id => params[:interview_id], :user_id => @user.id)
    # UserMailer
  end
  
  def view_campaign

    # @campaign = @user.client_company.campaigns.find(params[:id])
    @campaign = Campaign.find(params[:id])
    @campaign_traits = @campaign.campaign_traits.includes(:trait)
    @user_campaigns = @campaign.user_campaigns.includes(:user)
    @uc_hash = { :forwarded => @user_campaigns.select { |uc| uc.status == USER_CAMPAIGN_STATUS_FORWARDED },
                 :accepted =>  @user_campaigns.select { |uc| uc.status == USER_CAMPAIGN_STATUS_ACCEPTED },
                 :rejected =>  @user_campaigns.select { |uc| uc.status == USER_CAMPAIGN_STATUS_REJECTED }
               }
    render :partial =>'view_campaign'
  end
  def view_candidate
    @campaign = Campaign.find(params[:campaign_id])

    @candidate = User.includes(:traits).find(params[:candidate_id])
    @interviews =@candidate.given_interviews.where(:campaign => @campaign.id)
    # binding.pry
    render :partial =>'view_candidate'
  end
  def update_traits
    @campaign = Campaign.find(params[:id])
    if params[:campaign].present?
     @campaign.update_attributes(params[:campaign])
    end
    render :nothing => true
  end
  def company_details
      if @company = @user.client_company 
      else
         @company = Company.new
      end
    render :partial =>  (@company.update_attributes(params[:company]) ? 'company_details' : 'company_details')
  end

  def campaigns
    if params[:campaign].present?
      @campaign = @user.client_company.campaigns.build(params[:campaign])
      @campaign.save
    end
    @campaigns = @user.client_company.campaigns
    render :partial => 'campaigns'
    # render :partial =>  (@company.update_attributes(params[:company]) ? 'campaigns' : 'company_details')
  end
  
  def new_campaign
    @campaign = Campaign.new
    @traits = Trait.all
    # @trait = Trait.new
    render :partial =>'new_campaign'
  end    
  
  def set_user
      if current_user
        @user = current_user
        @user.user_profile ||= @user.build_user_profile 
      end
      @path = {:summary => client_summary_path, 
               :profile => client_profile_path,
               :company_details => client_company_details_path,
               :campaigns => client_campaigns_path,
               :new_campaign => client_new_campaign_path               
              }
  end
  
end
