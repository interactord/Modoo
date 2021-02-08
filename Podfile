platform :ios, '13.0'

inhibit_all_warnings!

def ui
  pod 'Texture'
  pod 'RxTexture2'
  pod 'BonMot'
end

def core
  pod 'RxSwift', '6.0.0'
  pod 'RxCocoa', '6.0.0'
  pod 'RxOptional'
end

def core_framework
  pod 'RIBs', :git => 'https://github.com/interactord/RIBs', :branch => 'master'
  pod 'ReactorKit'
end

target 'Application' do
  use_frameworks!
  core_framework
  core
  ui
  
  # Helper
  pod 'RxKeyboard'

  target 'ApplicationTests' do
    inherit! :search_paths
    core_framework
  end
end

target 'Domain' do
  use_frameworks!
  core
  target 'DomainTests' do
    inherit! :search_paths
    core
  end
end

target 'MediaPickerPlatform' do
  use_frameworks!
  core
  target 'MediaPickerPlatformTests' do
    inherit! :search_paths
    core
  end
end
