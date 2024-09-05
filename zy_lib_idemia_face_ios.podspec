#
# Be sure to run `pod lib lint zy-lib-idemia-face-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a1 # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'zy_lib_idemia_face_ios'
    s.version          = '6.4.15'
    s.summary          = 'libreria que pertenece a Zytrust SA zy-lib-idemia-face-ios.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://www.zytrust.com'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Ivan Caceres' => 'ztmobile@zytrust.com' }
    s.source           = { :git => 'https://github.com/ZYTRUST/zy_lib_idemia_face_ios.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '12.0'
    

    
    s.pod_target_xcconfig = {
        'ONLY_ACTIVE_ARCH' => 'YES'
    }
    s.static_framework = true

    s.vendored_frameworks = "Sources/zy_lib_idemia_face_ios.xcframework"
    s.resources = ['Sources/zy_lib_idemia_face_ios.bundle']

    
    s.dependency 'lottie-ios' , '~> 4.4.1'
    s.dependency 'zyBiometricSDK', '~> 4.34.10'
    s.dependency 'BiometricSDKAlgorithmPlugin_F6_0_IDD80', '~> 4.34.4'
    s.dependency 'BiometricSDKFaceCapturePluginNormal', '~> 4.34.4'
    s.dependency 'BiometricSDKUIFaceModePassiveCore', '~> 2.3.5'

    
end
