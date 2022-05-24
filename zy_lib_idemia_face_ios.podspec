#
# Be sure to run `pod lib lint zy-lib-idemia-face-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a1 # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

    s.name         = "zy_lib_idemia_face_ios"
    s.version      = "3.0.2"
    s.summary      = "A brief description of zy_lib_idemia_face_ios project."
    s.description  = <<-DESC
    An extended description of zy_lib_idemia_face_ios project.
    DESC
    s.homepage         = 'https://github.com/ZYTRUST/zy_lib_idemia_face_ios'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }

    s.author           = { 'ZYTRUST SA' => 'ztmobile@zytrust.com' }
    s.source = { :http => "https://github.com/ZYTRUST/zy_lib_idemia_face_ios/archive/refs/tags/3.0.2.tar.gz" }
    #s.public_header_files = "zy_lib_idemia_face_ios.framework/Headers/*.h"
    #s.source_files = "zy_lib_idemia_face_ios.framework/Headers/*.h"
    #s.vendored_frameworks = "zy_lib_idemia_face_ios.framework"
    s.ios.deployment_target = '12.0'
  
    s.dependency 'lottie-ios', '~> 3.3.0'

  
    s.swift_version = '5.0'


end

