Pod::Spec.new do |s|
  s.name         = "BLSNavigationController"
  s.version      = "0.0.1"
  s.summary      = "iOS navigation controller with progress bar and TweetBot 3-like back button for navigation"

  s.homepage     = "https://github.com/thomasjcarey/BLSNavigationController"
  s.screenshots  = "https://raw.githubusercontent.com/thomasjcarey/BLSNavigationController/master/demo.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Thomas Carey" => "jthomascarey@gmail.com" }
  s.social_media_url   = "http://twitter.com/_tcarey"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/thomasjcarey/BLSNavigationController.git", :tag => "0.0.1" }


  s.source_files  = "BLSNavigationController", "BLSNavigationController/**/*.{swift}"
  s.frameworks = "UIKit", "WebKit"

  s.requires_arc = true
end
