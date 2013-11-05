Rails.application.config.middleware.use OmniAuth::Builder do
  
  
  # provider :google_oauth2, '104804342414.apps.googleusercontent.com', 'nWuVV8UBG-8TOCauJ3H44gcC'
  # provider :google_oauth2, ENV["104804342414.apps.googleusercontent.com"], ENV["nWuVV8UBG-8TOCauJ3H44gcC"]
   
  # provider :linkedin, "cyxno8hbya22", "o0drCYYKOP0fhaYa"
  # provider :linkedin, "cyxno8hbya22", "o0drCYYKOP0fhaYa"
  # require 'omniauth-deezer'
  
  
  provider :linkedin, "cyxno8hbya22", "o0drCYYKOP0fhaYa"
  
  
  provider :google_oauth2, "104804342414.apps.googleusercontent.com", "nWuVV8UBG-8TOCauJ3H44gcC"
  
  # TESTING 
  # provider :google_oauth2, '44912071201.apps.googleusercontent.com','biic8-bonN8ZGcjeZJQJAhCT'
  
  # provider :facebook, '344914352305502', 'ac787e2667d406843fe07abb1de63db7'
end