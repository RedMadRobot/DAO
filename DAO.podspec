Pod::Spec.new do |s|
  s.name             = 'DAO'
  s.version          = '1.0.1'
  s.summary          = 'DAO Library'
  s.description      = 'Library provides easy way to cache entities.'
  s.homepage         = 'https://github.com/RedMadRobot/DAO'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'vani2' => 'iv@redmadrobot.com' }
  s.source           = { :git => 'https://github.com/RedMadRobot/DAO.git', :tag => '1.0.0', :submodules => true }
  s.platform         = :ios, '9.0'
  s.source_files     = 'DAO/Classes/Core/**/*'
  
  s.subspec 'Realm' do |r|
      r.source_files = 'DAO/Classes/RealmDAO/**/*', 'DAO/Classes/Core/**/*'
      r.dependency "RealmSwift"
  end
  
  s.subspec 'CoreData' do |cd|
      cd.source_files = 'DAO/Classes/CoreDataDAO/**/*', 'DAO/Classes/Core/**/*'
  end

end
