import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:messaging_zen/messaging_zen.dart';
import 'package:messaging_zen_flutter_client_spike/src/common/constants.dart';

import 'chat_window_portal.dart';

class ZendeskScreen extends StatefulWidget {
  const ZendeskScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<ZendeskScreen> createState() => _ZendeskScreenState();
}

class _ZendeskScreenState extends State<ZendeskScreen> {
  final MessagingZen _messagingZen = MessagingZen(
    webScriptId: messagingZenWebScriptId,
    webScriptSrc: messagingZenWebScriptSrc,
    androidChannelKey: messagingZenAndroidChannelKey,
    iosChannelKey: messagingZenIosChannelKey,
  );

  // State of chat
  Widget? chatWidget;
  bool chatWidgetVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zendesk Spike"),
      ),
      floatingActionButton: FloatingActionButton(
        child: PortalTarget(
          visible: chatWidgetVisible,
          anchor: const Aligned(
            follower: Alignment.bottomRight,
            target: Alignment.topRight,
            offset: Offset(15, -25),
          ),
          portalFollower: ChatWindowPortal(chatWidget: chatWidget),
          child: const Icon(Icons.chat),
        ),
        onPressed: () async {
          // Initialize Zendesk Messaging
          await _messagingZen.initialize();

          Widget? _messagingZenWidget = await _messagingZen.show();

          // Show the Zendesk Messaging interface
          setState(() {
            chatWidget = _messagingZenWidget;
            if (_messagingZenWidget != null) {
              chatWidgetVisible = !chatWidgetVisible;
            }
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Text("Zendesk implementation."),
            SizedBox(height: 10.0),
            Text("This screen should allow a zendesk messaging channel chat to be opened."),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
