platform :ios, '13.0'

inhibit_all_warnings!

target 'Application' do
  use_frameworks!
  
  # UI
  pod 'Texture'
  pod 'RxTexture2'
  pod 'RxDataSources-Texture'
  pod 'BonMot'
  pod 'Texture/IGListKit'
  pod 'IGListKit'
  pod 'RxIGListKit'

  # Rx
  pod 'RxSwift', '6.0.0'
  pod 'RxCocoa', '6.0.0'
  pod 'RxOptional'
  pod 'RxKeyboard'

  # Framework
  pod 'RIBs', :git => 'https://github.com/interactord/RIBs', :branch => 'master'
  pod 'ReactorKit'
  
  # Misc.
  pod 'SwiftLint'

  # Firebase
  pod "Firebase/Core"
  pod "Firebase/Database"
  pod "Firebase/Firestore"
  pod "Firebase/Messaging"
  pod "Firebase/Storage"
  pod "Firebase/Auth"

  target 'ApplicationTests' do
    inherit! :search_paths
    
    # Framework
    pod 'RIBs', :git => 'https://github.com/interactord/RIBs', :branch => 'master'
    pod 'ReactorKit'
    pod 'Texture'
    pod 'RxIGListKit'
    pod 'RxSwift', '6.0.0'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
    end
  end
end
