/// Application Initialization Processes
void appInit() {
  try {
    // OPTIONAL: INITIALIZE ZENDESK MESSENGER AT APP STARTUP
    // DEFAULT

    // // Get Environment Variables for Zendesk initialization
    // const String? androidChannelKey = String.fromEnvironment("ANDROID_CHANNEL_KEY");
    // const String? iosChannelKey = String.fromEnvironment("IOS_CHANNEL_KEY");
    // const String? webScriptId = String.fromEnvironment("WEB_SCRIPT_ID");
    // const String? webScriptSrc = String.fromEnvironment("WEB_SCRIPT_SRC");
    //
    // logger.d(
    //     "Android Channel Key: $androidChannelKey\niOS Channel Key: $iosChannelKey\nWeb Script ID: $webScriptId\nWeb Script Src: $webScriptSrc");
    //
    // // Initialize Zendesk
    // MessagingZen.initialize(
    //   androidChannelKey: androidChannelKey,
    //   iosChannelKey: iosChannelKey,
    //   webScriptId: webScriptId,
    //   webScriptSrc: webScriptSrc,
    // );
  } catch (e) {
    rethrow;
  }
}
