#
# Be sure to run `pod lib lint AwesomeContactPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AwesomeContactPicker'
  s.version          = '0.2.0'
  s.summary          = 'Fast & customizable integration of contacts picker into your awesome apps'
  
  s.description      = <<-DESC
  AwesomeContactPicker help you search and pick single or multiple contacts from the device, with multiple customizable settings.
  DESC
  
  s.homepage         = 'https://github.com/MichaelGuoXY/AwesomeContactPicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michael Guo' => 'xg229@cornell.edu' }
  s.source           = { :git => 'https://github.com/MichaelGuoXY/AwesomeContactPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/XiaoyuGuo3'
  
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  
  s.source_files = 'AwesomeContactPicker/Classes/**/*'
  
  s.resource_bundles = {
    'AwesomeContactPicker' => ['AwesomeContactPicker/Assets/*']
  }
  
end
