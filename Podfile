source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

def test_pods
    inherit! :search_paths
end

target 'SwipeNumbers' do
    pod 'Google-Mobile-Ads-SDK'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '5.3'
        end
    end
end
