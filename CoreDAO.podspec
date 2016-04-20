Pod::Spec.new do |s|
  s.name         = "CoreDAO"
  s.version      = "1.0.0"
  s.summary      = "CoreDAO Library"
  s.description  = “Library provide easy way to cache entities.”
  s.homepage     = "http://git.redmadrobot.com/foundation-iOS/DAO.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Ivan Vavilov" => "vi@redmadrobot.com", "Igor Bulyga" => "ib@redmadrobot.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "git@git.redmadrobot.com:foundation-ios/DAO.git" }
  s.source_files = "Source/CoreDAO/Classes/**/*"
  s.requires_arc = true
  s.dependency "RealmSwift"
end