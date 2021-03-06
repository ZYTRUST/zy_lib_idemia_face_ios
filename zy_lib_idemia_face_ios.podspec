#
# Be sure to run `pod lib lint zy-lib-idemia-face-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a1 # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'zy_lib_idemia_face_ios'
  s.version          = '6.0.2'
    s.summary      = "A brief description of zy_lib_idemia_face_ios project."
    s.description  = <<-DESC
    An extended description of zy_lib_idemia_face_ios project.
    DESC
    s.homepage     = "http://www.zytrust.com"
    s.license          = { :type => 'MIT', :file => 'LICENSE' }

    s.author = { "$(git config user.name)" => "$(git config user.email)" }
    #s.source = { :git => "https://github.com/ZYTRUST/zy_lib_idemia_face_ios.git", :tag => s.version.to_s}
    s.source           = { :http => "https://github.com/ZYTRUST/zy_lib_idemia_face_ios/releases/download/4.0.0/zy_lib_idemia_face_ios.tar.gz" }
    s.public_header_files = "zy_lib_idemia_face_ios.framework/Headers/*.h"
    s.source_files = "zy_lib_idemia_face_ios.framework/Headers/*.h"
    s.ios.vendored_frameworks = "zy_lib_idemia_face_ios.framework"
    s.platform = :ios
    #s.swift_version = "4.2"
    s.ios.deployment_target  = '11.0'

    #s.dependency 'lottie-ios', '~> 3.3.0'
    #s.dependency 'BiometricSDKUIExtensions', '~> 1.5.3'
    #s.dependency 'BiometricSDK', '~> 4.23.0'
    #s.dependency 'BiometricSDKAlgorithmPlugin_F5_0_VID81', '~> 4.23.0'
    #s.dependency 'BiometricSDKFaceCapturePluginNormal', '~> 4.23.0'

   s.pod_target_xcconfig = {
    'ONLY_ACTIVE_ARCH' => 'NO'
}
end
