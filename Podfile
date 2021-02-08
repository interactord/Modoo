platform :ios, '13.0'

inhibit_all_warnings!

target 'Application' do
  use_frameworks!
  
  # UI
  pod 'Texture'
  pod 'RxTexture2'
  pod 'BonMot'

  # Rx
  pod 'RxSwift', '6.0.0'
  pod 'RxCocoa', '6.0.0'
  pod 'RxOptional'
  pod 'RxKeyboard'

  # Framwork
  pod 'RIBs', :git => 'https://github.com/interactord/RIBs', :branch => 'master'
  pod 'ReactorKit'
  
  # Misc.
  pod 'SwiftLint'

  target 'ApplicationTests' do
    inherit! :search_paths
    
    # Framwork
    pod 'RIBs', :git => 'https://github.com/interactord/RIBs', :branch => 'master'
    pod 'ReactorKit'
    pod 'RxSwift', '6.0.0'
  end
end
