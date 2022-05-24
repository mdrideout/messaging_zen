#import "MessagingZenIosPlugin.h"
#if __has_include(<messaging_zen_ios/messaging_zen_ios-Swift.h>)
#import <messaging_zen_ios/messaging_zen_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "messaging_zen_ios-Swift.h"
#endif

@implementation MessagingZenIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMessagingZenIosPlugin registerWithRegistrar:registrar];
}
@end
