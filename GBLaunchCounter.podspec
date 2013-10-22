Pod::Spec.new do |s|
  s.name         = "GBLaunchCounter"
  s.version      = "1.0.0"
  s.summary      = "Wrapper facade for simplifying the Core Motion APIs and exposing a blocks based interface."
  s.homepage     = "https://github.com/lmirosevic/GBLaunchCounter"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "Luka Mirosevic" => "luka@goonbee.com" }
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6'
  s.source       = { :git => "https://github.com/lmirosevic/GBLaunchCounter.git", :tag => "1.0.0" }
  s.source_files  = 'GBLaunchCounter/GBLaunchCounter.{h,m}'
  s.public_header_files = 'GBLaunchCounter/GBLaunchCounter.h'
  s.requires_arc = true

  s.dependency 'GBToolbox'
  s.dependency 'GBStorageController'
end
