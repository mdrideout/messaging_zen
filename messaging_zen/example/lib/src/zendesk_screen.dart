import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messaging_zen/messaging_zen.dart';

import 'common/constants.dart';

class ZendeskScreen extends StatefulWidget {
  const ZendeskScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<ZendeskScreen> createState() => _ZendeskScreenState();
}

class _ZendeskScreenState extends State<ZendeskScreen> {
  final MessagingZen _messagingZen = MessagingZen(
    nickname: "default",
    webScriptId: messagingZenWebScriptId,
    webScriptSrc: messagingZenWebScriptSrc,
    androidChannelKey: messagingZenAndroidChannelKey,
    iosChannelKey: messagingZenIosChannelKey,
  );

  @override
  void initState() {
    super.initState();

    // Initialize MessagingZen instance
    _messagingZen.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messaging Zen Demo"),
      ),
      floatingActionButton: (kIsWeb)
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.chat),
              onPressed: () async {
                // Show the native Zendesk Messaging SDK view
                await _messagingZen.show();
              },
            ),
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 10.0),
            Text(
              "Cross-Platform\nZendesk Messaging SDK Implementation\niOS, Android, Web\n\nSee platform specific examples for more.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
