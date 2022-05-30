#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint messaging_zen_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'messaging_zen_ios'
  s.version          = '0.0.1'
  s.summary          = 'The iOS implementation of the Zendesk Messaging SDK'
  s.description      = <<-DESC
The iOS implementation of the Zendesk Messaging SDK
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'ZendeskSDKMessaging', '~>2.1.0'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
