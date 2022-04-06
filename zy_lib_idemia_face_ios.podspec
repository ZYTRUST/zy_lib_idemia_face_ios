#
# Be sure to run `pod lib lint zy-lib-idemia-face-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a1 # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

    s.name         = "zy_lib_idemia_face_ios"
    s.version      = "2.0.6"
    s.summary      = "A brief description of zy_lib_idemia_face_ios project."
    s.description  = <<-DESC
    An extended description of zy_lib_idemia_face_ios project.
    DESC
    s.homepage     = "http://www.zytrust.com"
    s.license          = { :type => 'MIT', :file => 'LICENSE' }

    s.author = { "$(git config user.name)" => "$(git config user.email)" }
    s.source = { :git => "https://github.com/ZYTRUST/zy_lib_idemia_face_ios.git", :tag => "2.0.6" }
    s.public_header_files = "zy_lib_idemia_face_ios.framework/Headers/*.h"
    s.source_files = "zy_lib_idemia_face_ios.framework/Headers/*.h"
    s.vendored_frameworks = "zy_lib_idemia_face_ios.framework"
    s.platform = :ios
    #s.swift_version = "4.2"
    s.ios.deployment_target  = '11.0'

    s.dependency = 'lottie-ios', '~> 3.3.0'
    s.dependency = 'BiometricSDK', :git => 'https://github.com/ZYTRUST/BiometricSDK.git'
    s.dependency = 'BiometricSDKAlgorithmPlugin_F5_0_VID81', :git => 'https://github.com/ZYTRUST/BiometricSDKAlgorithmPlugin_F5_0_VID81.git'
    s.dependency = 'BiometricSDKFaceCapturePluginNormal', :git => 'https://github.com/ZYTRUST/BiometricSDKFaceCapturePluginNormal.git'
    s.dependency = 'BiometricSDKUIExtensions', :git => 'https://github.com/ZYTRUST/BiometricSDKUIExtensions.git'
end

