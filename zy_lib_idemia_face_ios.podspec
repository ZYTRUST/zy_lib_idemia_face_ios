#
# Be sure to run `pod lib lint zy-lib-idemia-face-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a1 # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'zy_lib_idemia_face_ios'
    s.version          = '6.3.3'
    s.summary          = 'A short description of zy-lib-idemia-face-ios.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/Ivan Caceres/zy-lib-idemia-face-ios'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Ivan Caceres' => 'icaceres@zytrust.com' }
    s.source           = { :git => 'https://github.com/Ivan Caceres/zy-lib-idemia-face-ios.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '12.0'
    
    s.vendored_frameworks = "zy_lib_idemia_face_ios.framework"

    s.source_files = 'zy_lib_idemia_face_ios/Classes/**/*'
    
    
    # YES -> SOLO TOMA ARM64
    # NO  -> TOMA ARM64 Y ARMV7
    s.pod_target_xcconfig = {
        'ONLY_ACTIVE_ARCH' => 'YES'
    }
    
    #s.resource_bundles = {
    #    'zy_lib_idemia_face_ios' => ['zy_lib_idemia_face_ios/Assets/*.{lproj,storyboard,xcassets,png}']
    #}
    
    #s.resources = 'zy_lib_idemia_face_ios/Assets/*.{lproj,storyboard,xcassets,png}'
    
    #s.public_header_files = 'zy_lib_idemia_face_ios/Classes/**/*.h'
    s.static_framework = true
    # s.frameworks = 'UIKit', 'MapKit'
    
    s.dependency 'BiometricSDK', '~> 4.34.1'
    s.dependency 'BiometricSDKAlgorithmPlugin_F6_0_IDD80', '~> 4.34.1'
    s.dependency 'BiometricSDKFaceCapturePluginNormal', '~> 4.34.1'
    s.dependency 'BiometricSDKUIExtensions', '~> 1.5.3'
    s.dependency 'ZyIdemiaUIFacial', '~> 0.1.3'
    s.dependency 'lottie-ios', '3.3.0'
    
    
end
