platform :ios, '13.0'

inhibit_all_warnings!
use_frameworks!

target 'Application' do
  #Framework
  pod 'RIBs', :git => 'https://github.com/interactord/RIBs', :branch => 'master'

  # UI
  pod 'Texture'
  pod 'RxTexture2'
  pod 'BonMot'
  pod 'ReactorKit'

  # Misc.
  pod 'SwiftLint'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
    end
  end

  sharedLibrary = installer.aggregate_targets.find { |aggregate_target| aggregate_target.name == 'Pods-[MY_FRAMEWORK_TARGET]' }
  installer.aggregate_targets.each do |aggregate_target|
    if aggregate_target.name == 'Pods-[MY_APP_TARGET]'
      aggregate_target.xcconfigs.each do |config_name, config_file|
        sharedLibraryPodTargets = sharedLibrary.pod_targets
        aggregate_target.pod_targets.select { |pod_target| sharedLibraryPodTargets.include?(pod_target) }.each do |pod_target|
          pod_target.specs.each do |spec|
            frameworkPaths = unless spec.attributes_hash['ios'].nil? then spec.attributes_hash['ios']['vendored_frameworks'] else spec.attributes_hash['vendored_frameworks'] end || Set.new
            frameworkNames = Array(frameworkPaths).map(&:to_s).map do |filename|
              extension = File.extname filename
              File.basename filename, extension
            end
          end
          frameworkNames.each do |name|
            if name != '[DUPLICATED_FRAMEWORK_1]' && name != '[DUPLICATED_FRAMEWORK_2]'
              raise("Script is trying to remove unwanted flags: #{name}. Check it out!")
            end
            puts "Removing #{name} from OTHER_LDFLAGS"
            config_file.frameworks.delete(name)
          end
        end
      end
      xcconfig_path = aggregate_target.xcconfig_path(config_name)
      config_file.save_as(xcconfig_path)
    end
  end
end
