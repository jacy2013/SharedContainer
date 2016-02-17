Pod::Spec.new do |s|
  s.name         = "SharedContainer"
  s.version      = "1.0.1"
  s.summary      = "Thin wrapper is TransPadQ2.0 shared framework."
  s.homepage     = "https://github.com/jacy2013/SharedContainer"
  s.license      = 'Apache License, Version 2.0'
  s.author       = {'KongXiaojun' => 'https://github.com/jacy2013'}
  s.source       = { :git => 'https://github.com/jacy2013/SharedContainer.git',  :branch => "master"}
  s.social_media_url = 'https://github.com/jacy2013'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'SharedContainer/'
  s.requires_arc = 'true'
end
