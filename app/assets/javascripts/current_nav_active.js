$( document ).ajaxComplete(function( event, xhr, settings) {
	//alert(xhr.getResponseHeader('X-Message'));
	//alert(settings.data);
	// 
	if ( settings.url.match(/user_profiles/g) ){
	}else{
		$('.current').removeClass('current');
	}

  switch(settings.url){
     case '/user_profiles/summary':
        $( ".PageTitle" ).html( "Candidate dashboard" );
        break;
     case '/user_profiles/work_eligibility':
        $( ".PageTitle" ).html( "Work Eligibility" );
        break;
     case '/user_profiles/personal_details':
        $( ".PageTitle" ).html( "Personal Details" );
        break;   
     case '/user_profiles/employment_details':
        $( ".PageTitle" ).html( "Employment Details" );
        break;
     case '/user_profiles/upload_cv':
        $( ".PageTitle" ).html( "Upload CV");
        break;
     case '/user_profiles/online_test_link_click':
        $( ".PageTitle" ).html( "Online Test");
        break;
     case '/user_profiles/online_test':
        $( ".PageTitle" ).html( "Online Test");
        break;   
     case '/user_profiles/qualifications':
        $( ".PageTitle" ).html( "Qualifications");
        break; 
     case '/user_profiles/skills':
        $( ".PageTitle" ).html( "Skills" );
        break;
	// For Client Right Side navigation        
     case '/client/summary':
        $('.icon-dashboard, .-dashboard').addClass('current');
        $( ".PageTitle" ).html( "client dashboard" );
        break;
     case '/client/profile':
        $('.icon-contact, .-contact').addClass('current');
        $( ".PageTitle" ).html( "your profile" );
        break;
     case '/client/company_details':
        $('.icon-companies, .-companies').addClass('current');
        $( ".PageTitle" ).html( "company details" );
        break;
     case '/client/campaigns':
        $('.icon-compaigns, .-compaigns').addClass('current');
        $( ".PageTitle" ).html( "campaigns" );
        break;
     case '/client/new_campaign':
        $('.icon-compaign-new, .-compaign-new').addClass('current');
        $( ".PageTitle" ).html( "new campaign" );
        break;
  }
   
});